locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  region              = var.location != null ? lookup({ northeurope = "neu", westeurope = "weu", westus2 = "wu2", brazilsouth = "brs", eastus = "eus", centralindia = "cin", germanywestcentral = "gwc", southeastasia = "sea", westus3 = "wu3", uksouth = "uks", global = "glb" }, var.location, null) : "test"
  default_failover_locations = {
    default = {
      location       = var.location
      zone_redundant = var.zone_redundancy_enabled
    }
  }
  firewall_ips = var.firewall_ip == [] ? "${join(",", var.azure_portal_access, var.azure_dc_access)}" : "${join(",", var.firewall_ip, var.azure_portal_access, var.azure_dc_access)}"
}