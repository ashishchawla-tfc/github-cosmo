#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------

data "azurerm_client_config" "main" {}

data "azurerm_resource_group" "rgrp" {
  provider = azurerm
  count    = var.create_resource_group == false ? 1 : 0
  name     = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  provider = azurerm
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = var.tags
}


// test
#---------------------------------------------------------
# Azure Cosmos DB
#----------------------------------------------------------
resource "azurerm_cosmosdb_account" "main" {
  name                                  = var.cosmos_account_name
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  minimal_tls_version                   = var.minimal_tls_version
  offer_type                            = "Standard"
  create_mode                           = lower(var.backup_type) == "continuous" ? var.create_mode : "Default"
  kind                                  = var.cosmos_api == "mongo" ? "MongoDB" : "GlobalDocumentDB"
  public_network_access_enabled         = var.public_network_access_enabled
  ip_range_filter                       = var.ip_firewall_enabled == true ? local.firewall_ips : null
  free_tier_enabled                     = var.free_tier_enabled
  automatic_failover_enabled            = var.automatic_failover_enabled
  partition_merge_enabled               = var.partition_merge_enabled
  multiple_write_locations_enabled      = var.enable_multiple_write_locations
  mongo_server_version                  = var.mongo_dbs != null ? var.mongo_server_version : null
  key_vault_key_id                      = var.key_vault_name != null ? data.azurerm_key_vault_key.main[0].versionless_id : null
  is_virtual_network_filter_enabled     = var.is_virtual_network_filter_enabled
  network_acl_bypass_for_azure_services = var.network_acl_bypass_for_azure_services
  network_acl_bypass_ids                = var.network_acl_bypass_ids
  local_authentication_disabled         = var.cosmos_api == "sql" ? var.local_authentication_disabled : false
  tags                                  = var.tags

  consistency_policy {
    consistency_level       = var.consistency_policy_level
    max_interval_in_seconds = var.consistency_policy_max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy_max_staleness_prefix
  }

  capacity {
    total_throughput_limit = var.capacity_total_throughput_limit
  }

  dynamic "capabilities" {
    for_each = var.cosmos_api == "sql" ? [] : [1]
    content {
      name = var.capabilities[var.cosmos_api]
    }
  }

  dynamic "capabilities" {
    for_each = var.additional_capabilities != null ? var.additional_capabilities : []
    content {
      name = capabilities.value
    }
  }

  dynamic "geo_location" {
    for_each = var.failover_locations != null ? var.failover_locations : local.default_failover_locations
    content {
      location          = geo_location.value.location
      failover_priority = lookup(geo_location.value, "failover_priority", 0)
      zone_redundant    = lookup(geo_location.value, "zone_redundant", false)
    }
  }

  dynamic "backup" {
    for_each = var.backup_enabled == true ? [1] : []
    content {
      type                = title(var.backup_type)
      tier                = lower(var.backup_type) == "periodic" ? var.backup_tier : "Continuous7Days"
      interval_in_minutes = lower(var.backup_type) == "periodic" ? var.backup_interval : ""
      retention_in_hours  = lower(var.backup_type) == "periodic" ? var.backup_retention : ""
      storage_redundancy  = lower(var.backup_type) == "periodic" ? var.backup_storage_redundancy : ""
    }
  }

  dynamic "analytical_storage" {
    for_each = var.analytical_storage.enabled ? [1] : []
    content {
      schema_type = var.analytical_storage.schema_type
    }
  }

  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rule != null ? toset(var.virtual_network_rule) : []
    content {
      id                                   = virtual_network_rule.value.id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value.ignore_missing_vnet_service_endpoint
    }
  }

  dynamic "cors_rule" {
    for_each = var.cors_rule != null ? ["enabled"] : []
    content {
      allowed_headers    = cors_rule.value.allowed_headers
      allowed_methods    = cors_rule.value.allowed_methods
      allowed_origins    = cors_rule.value.allowed_origins
      exposed_headers    = cors_rule.value.exposed_headers
      max_age_in_seconds = lookup(var.cors_rule, "max_age_in_seconds", null)
    }
  }

  dynamic "identity" {
    for_each = var.enable_systemassigned_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  lifecycle {
    ignore_changes = [
      default_identity_type
    ]
  }
}

#---------------------------------------------------------
# Private Link for Data Factory - Default is "false" 
#---------------------------------------------------------
# Private endpoint data dependencies 
# Subnet where PE will be created 
data "azurerm_subnet" "pe_subnet" {
  for_each             = var.private_endpoint
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_rg_name
}

# Resource group of the VNET-Subnet where PE will be created 
data "azurerm_resource_group" "pe_vnet_rg" {
  for_each = var.private_endpoint
  name     = each.value.vnet_rg_name
}

# Private DNS Zone where the A record for the PE will be inserted 
data "azurerm_private_dns_zone" "pe_private_dns_zone" {
  provider            = azurerm.Shared_Services
  for_each            = var.private_endpoint
  name                = var.private_dns_zone_name[var.cosmos_api]
  resource_group_name = each.value.dns_zone_rg_name
}

resource "azurerm_private_endpoint" "main" {
  for_each            = var.private_endpoint
  name                = each.value.name
  location            = data.azurerm_resource_group.pe_vnet_rg[each.key].location
  resource_group_name = data.azurerm_resource_group.pe_vnet_rg[each.key].name
  subnet_id           = data.azurerm_subnet.pe_subnet[each.key].id

  dynamic "private_dns_zone_group" {
    for_each = each.value.enable_private_dns_entry ? [1] : []
    content {
      name                 = each.value.dns_zone_group_name != "" ? each.value.dns_zone_group_name : "default"
      private_dns_zone_ids = [data.azurerm_private_dns_zone.pe_private_dns_zone[each.key].id]
    }
  }

  private_service_connection {
    name                           = each.value.private_service_connection_name != "" ? each.value.private_service_connection_name : "privateserviceconnection"
    private_connection_resource_id = azurerm_cosmosdb_account.main.id
    is_manual_connection           = each.value.is_manual_connection != "" ? each.value.is_manual_connection : false
    subresource_names              = [var.pe_subresource[var.cosmos_api]]
  }

  tags = var.tags
}