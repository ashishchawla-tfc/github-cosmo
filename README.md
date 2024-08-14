# Azure Cosmosdb Terraform Module

Manages a CosmosDB Account.

## Module Uses

```hcl
module "cosmos-db" {
  source                = "app.terraform.io/Teleperformance-GCC/cosmosdb/azure"
  version               = "1.0.1"
  create_resource_group = false
  resource_group_name   = "azgpoc-neu-bbtf-rg01"
  location              = "northeurope"  
  cosmos_api            = "cassandra"
  cassandra_keyspaces = {
    one = {
      keyspace_name           = "keyspacenoautoscale"
      keyspace_throughput     = 400
      keyspace_max_throughput = null
    },
    two = {
      keyspace_name           = "keyspaceautoscale"
      keyspace_throughput     = null
      keyspace_max_throughput = 1000
    }
  }
  cassandra_tables = {
    one = {
      keyspace_name          = "keyspaceautoscale"
      table_name             = "table1"
      default_ttl_seconds    = "86400"
      analytical_storage_ttl = null
      table_throughout       = 400
      table_max_throughput   = null
      cassandra_schema_settings = {
        column = {
          columnone = {
            column_key_name = "loadid"
            column_key_type = "uuid"
          },
          columntwo = {
            column_key_name = "machine"
            column_key_type = "uuid"
          },
          columnthree = {
            column_key_name = "mtime"
            column_key_type = "int"
          }
        }
        partition_key = {
          partition_key_one = {
            partition_key_name = "loadid"
          }
        }
        cluster_key = null
      }
    },
    two = {
      keyspace_name          = "keyspacenoautoscale"
      table_name             = "table2"
      default_ttl_seconds    = "86400"
      analytical_storage_ttl = null
      table_throughout       = 400
      table_max_throughput   = null
      cassandra_schema_settings = {
        column = {
          columntwo = {
            column_key_name = "loadid"
            column_key_type = "uuid"
          }
        }
        partition_key = {
          partition_key_two = {
            partition_key_name = "loadid"
          }
        }
        cluster_key = null
      }
    }
  }
  tags = {
    "ApplicationSupportDL"   = "GlobalCloudSupport@teleperformance.com",
    "Budget"                 = "00",
    "BudgetOwner"            = "Ankur.Vithalani@teleperformance.com",
    "CostOwner"              = "Ankur.Vithalani@teleperformance.com",
    "Country"                = "India",
    "DeploymentType"         = "NN",
    "FinanceSpoc"            = "Ankur.Vithalani@teleperformance.com",
    "ProjectOwner"           = "raviraj.mehetre@teleperformance.com",
    "ProjectOwnerSupervisor" = "Ankur.Vithalani@teleperformance.com",
    "ProjectName"            = "BBTF",
    "Region"                 = "India",
    "SDTicketNo"             = "123456789",
    "SubsidiaryDepartment"   = "IT",
    "SubsidiaryName"         = "Teleperformance India",
    "Vertical"               = "IT",
  }
  enable_diagnostic_settings = true
  log_analytics_workspace_id = "/subscriptions/0fc7c31e-92f7-4e21-a24d-c003a52a926f/resourcegroups/azpoc-neu-log-rg01/providers/microsoft.operationalinsights/workspaces/azpoc-neu-log01"

}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.113.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.113.0 |
| <a name="provider_azurerm.Shared_Services"></a> [azurerm.Shared\_Services](#provider\_azurerm.Shared\_Services) | >= 3.113.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_cassandra_keyspace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_keyspace) | resource |
| [azurerm_cosmosdb_cassandra_table.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_table) | resource |
| [azurerm_cosmosdb_gremlin_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_gremlin_database) | resource |
| [azurerm_cosmosdb_gremlin_graph.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_gremlin_graph) | resource |
| [azurerm_cosmosdb_mongo_collection.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_collection) | resource |
| [azurerm_cosmosdb_mongo_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_sql_container.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_cosmosdb_table.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table) | resource |
| [azurerm_monitor_diagnostic_setting.ds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_key.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_monitor_diagnostic_categories.dc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_private_dns_zone.pe_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.pe_vnet_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.pe_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_capabilities"></a> [additional\_capabilities](#input\_additional\_capabilities) | List of additional capabilities for Cosmos DB API. - possible options are DisableRateLimitingResponses, EnableAggregationPipeline, EnableServerless, mongoEnableDocLevelTTL, MongoDBv3.4, AllowSelfServeUpgradeToMongo36 | `list(string)` | `[]` | no |
| <a name="input_analytical_storage"></a> [analytical\_storage](#input\_analytical\_storage) | Analytical storage enablement.<br>`enabled` - Enable Analytical Storage option for this Cosmos DB account.<br>`schema_type` - The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`. | <pre>object({<br>    enabled     = bool<br>    schema_type = string<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "schema_type": null<br>}</pre> | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | (Optional) Enable automatic failover for this Cosmos DB account. | `bool` | `false` | no |
| <a name="input_azure_dc_access"></a> [azure\_dc\_access](#input\_azure\_dc\_access) | List of ip address to enable the Accept connections from within public Azure datacenters behavior. | `list(string)` | <pre>[<br>  "0.0.0.0"<br>]</pre> | no |
| <a name="input_azure_portal_access"></a> [azure\_portal\_access](#input\_azure\_portal\_access) | List of ip address to enable the Allow access from the Azure portal behavior. | `list(string)` | <pre>[<br>  "104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"<br>]</pre> | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | Enable backup for this Cosmos DB account | `bool` | `true` | no |
| <a name="input_backup_interval"></a> [backup\_interval](#input\_backup\_interval) | The interval in minutes between two backups. This is configurable only when type is Periodic. Possible values are between 60 and 1440. | `string` | `60` | no |
| <a name="input_backup_retention"></a> [backup\_retention](#input\_backup\_retention) | The time in hours that each backup is retained. This is configurable only when type is Periodic. Possible values are between 8 and 720. | `string` | `8` | no |
| <a name="input_backup_storage_redundancy"></a> [backup\_storage\_redundancy](#input\_backup\_storage\_redundancy) | The storage redundancy which is used to indicate type of backup residency. This is configurable only when type is Periodic. Possible values are Geo, Local and Zone | `string` | `"Geo"` | no |
| <a name="input_backup_tier"></a> [backup\_tier](#input\_backup\_tier) | (Optional) The continuous backup tier. Possible values are `Continuous7Days` and `Continuous30Days`. | `string` | `"Continuous7Days"` | no |
| <a name="input_backup_type"></a> [backup\_type](#input\_backup\_type) | Type of backup - can be either Periodic or Continuous | `string` | `"periodic"` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | Map of non-sql DB API to enable support for API other than SQL | `map(any)` | <pre>{<br>  "cassandra": "EnableCassandra",<br>  "gremlin": "EnableGremlin",<br>  "mongo": "EnableMongo",<br>  "sql": "SQL",<br>  "table": "EnableTable"<br>}</pre> | no |
| <a name="input_capacity_total_throughput_limit"></a> [capacity\_total\_throughput\_limit](#input\_capacity\_total\_throughput\_limit) | (Required) The total throughput limit imposed on this Cosmos DB account (RU/s). Possible values are at least `-1`. `-1` means no limit. | `string` | `"-1"` | no |
| <a name="input_cassandra_keyspaces"></a> [cassandra\_keyspaces](#input\_cassandra\_keyspaces) | List of Cosmos DB Cassandra keyspaces to create. Some parameters are inherited from cosmos account.<br>  `keyspace_name` : Specifies the name of the Cosmos DB Cassandra KeySpace.<br>  `keyspace_throughput` : (Optional) The throughput of Cassandra KeySpace (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>   >  Note: throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support<br>   `keyspace_max_throughput` : (Optional) The maximum throughput of the Cassandra KeySpace (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput. | <pre>map(object({<br>    keyspace_name           = string<br>    keyspace_throughput     = optional(number)<br>    keyspace_max_throughput = optional(number)<br>  }))</pre> | `{}` | no |
| <a name="input_cassandra_tables"></a> [cassandra\_tables](#input\_cassandra\_tables) | List of Cosmos DB Cassandra tables to create. Some parameters are inherited from cosmos account.<br>  `table_name` : Specifies the name of the Cosmos DB Cassandra Table.<br>  `keyspace_name` : Specifies the name of the Cosmos DB Cassandra KeySpace.<br>  `default_ttl_seconds` : (Optional) Time to live of the Cosmos DB Cassandra table. Possible values are at least -1. -1 means the Cassandra table never expires.<br>  `analytical_storage_ttl` : (Optional) Time to live of the Analytical Storage. Possible values are between -1 and 2147483647 except 0. -1 means the Analytical Storage never expires. Changing this forces a new resource to be created.<br>  `table_throughout` : (Optional) The throughput of Cassandra KeySpace (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>  `table_max_throughput` : (Optional) The maximum throughput of the Cassandra Table (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br>  `cassandra_schema_settings` : A cassandra\_schema\_settings block supports the following<br>    - `column` : (Required) One or more column blocks as defined below.<br>      - `column_key_name` : (Required) Name of the column to be created.<br>      - `column_key_type` : (Required) Type of the column to be created.<br>    - `partition_key` : (Required) One or more partition\_key blocks as defined below.<br>      - `partition_key_name` : (Required) Name of the column to partition by.<br>    - `cluster_key` : (Optional) One or more cluster\_key blocks as defined below.<br>      - `cluster_key_name` : (Required) Name of the cluster key to be created.<br>      - `cluster_key_order_by` : (Required) Order of the key. Currently supported values are Asc and Desc. | <pre>map(object({<br>    table_name             = string<br>    keyspace_name          = string<br>    default_ttl_seconds    = optional(string)<br>    analytical_storage_ttl = optional(number)<br>    table_throughout       = optional(number)<br>    table_max_throughput   = optional(number)<br>    cassandra_schema_settings = object({<br>      column = map(object({<br>        column_key_name = string<br>        column_key_type = string<br>      }))<br>      partition_key = map(object({<br>        partition_key_name = string<br>      }))<br>      cluster_key = map(object({<br>        cluster_key_name     = string<br>        cluster_key_order_by = string<br>      }))<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_consistency_policy_level"></a> [consistency\_policy\_level](#input\_consistency\_policy\_level) | Consistency policy level. Allowed values are `BoundedStaleness`, `Eventual`, `Session`, `Strong` or `ConsistentPrefix` | `string` | `"BoundedStaleness"` | no |
| <a name="input_consistency_policy_max_interval_in_seconds"></a> [consistency\_policy\_max\_interval\_in\_seconds](#input\_consistency\_policy\_max\_interval\_in\_seconds) | When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency\_level is set to BoundedStaleness. | `number` | `10` | no |
| <a name="input_consistency_policy_max_staleness_prefix"></a> [consistency\_policy\_max\_staleness\_prefix](#input\_consistency\_policy\_max\_staleness\_prefix) | When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency\_level is set to BoundedStaleness. | `number` | `200` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | A cors\_rule block supports the following<br>`allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.<br>`allowed_methods` - (Required) A list of HTTP headers that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br>`allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.<br>`exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.<br>`max_age_in_seconds` - (Optional) The number of seconds the client should cache a preflight response. Possible values are between 1 and 2147483647. | <pre>list(object({<br>    allowed_headers    = list(string)<br>    allowed_methods    = list(string)<br>    allowed_origins    = list(string)<br>    exposed_headers    = list(string)<br>    max_age_in_seconds = optional(number)<br>  }))</pre> | `null` | no |
| <a name="input_cosmos_account_name"></a> [cosmos\_account\_name](#input\_cosmos\_account\_name) | Specifies the name of the CosmosDB Account. | `string` | `null` | no |
| <a name="input_cosmos_api"></a> [cosmos\_api](#input\_cosmos\_api) | Specifies the name of Cosmos API. | `string` | n/a | yes |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | (Optional) The creation mode for the CosmosDB Account. Possible values are `Default` and `Restore`. `Note:` `create_mode` can only be defined when the backup.type is set to `Continuous`. | `string` | `"Default"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Whether to create resource group and use it for all networking resources | `bool` | n/a | yes |
| <a name="input_enable_diagnostic_settings"></a> [enable\_diagnostic\_settings](#input\_enable\_diagnostic\_settings) | Whether to configure Diagnostic settings for Azure Kubernetes Service. | `bool` | n/a | yes |
| <a name="input_enable_multiple_write_locations"></a> [enable\_multiple\_write\_locations](#input\_enable\_multiple\_write\_locations) | Enable multiple write locations for this Cosmos DB account. | `bool` | `false` | no |
| <a name="input_enable_systemassigned_identity"></a> [enable\_systemassigned\_identity](#input\_enable\_systemassigned\_identity) | Enable System Assigned Identity | `bool` | `false` | no |
| <a name="input_failover_locations"></a> [failover\_locations](#input\_failover\_locations) | The name of the Azure region to host replicated data and their priority.<br>  Configures the geographic locations the data is replicated to and supports the following<br>  `location` - The name of the Azure region to host replicated data.<br>  `failover_priority` - The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. Changing this causes the location to be re-provisioned and cannot be changed for the location with failover priority 0.<br>  `zone_redundant` - Should zone redundancy be enabled for this region? | `map(map(string))` | `null` | no |
| <a name="input_firewall_ip"></a> [firewall\_ip](#input\_firewall\_ip) | List of ip address to allow access from the internet or on-premisis network. | `list(string)` | `[]` | no |
| <a name="input_free_tier_enabled"></a> [free\_tier\_enabled](#input\_free\_tier\_enabled) | Enable the option to opt-in for the free database account within subscription. | `bool` | `false` | no |
| <a name="input_gremlin_dbs"></a> [gremlin\_dbs](#input\_gremlin\_dbs) | Map of Cosmos DB Gremlin DBs to create. Some parameters are inherited from cosmos account.<br>  `db_name` : Specifies the name of the Cosmos DB Gremlin Database.<br>  `db_throughput` : (Optional) The throughput of the Gremlin database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>  > Note: throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support<br>  `db_max_throughput` : (Optional) The maximum throughput of the Gremlin database (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput. | <pre>map(object({<br>    db_name           = string<br>    db_throughput     = optional(number)<br>    db_max_throughput = optional(number)<br>  }))</pre> | `{}` | no |
| <a name="input_gremlin_graphs"></a> [gremlin\_graphs](#input\_gremlin\_graphs) | List of Cosmos DB Gremlin Graph to create. Some parameters are inherited from cosmos account.<br>  `graph_name` : Specifies the name of the Cosmos DB Gremlin Graph.<br>  `db_name` : Specifies the name of the Cosmos DB Gremlin Database.<br>  `partition_key_path` : (Required) Define a partition key.<br>  `partition_key_version` : (Optional) Define a partition key version. Changing this forces a new resource to be created. Possible values are 1and 2. This should be set to 2 in order to use large partition keys.<br>  `default_ttl_seconds` : (Optional) The default time to live (TTL) of the Gremlin graph. If the value is missing or set to "-1", items don't expire.<br>  `graph_throughput` : (Optional) The throughput of the Gremlin graph (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>  `graph_max_throughput` : (Optional) The maximum throughput of the Gremlin graph (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br>  `index_policy_settings` : An index\_policy block supports the following<br>   - `indexing_automatic` : (Optional) Indicates if the indexing policy is automatic. Defaults to true.<br>   - `indexing_mode` : (Required) Indicates the indexing mode. Possible values include: Consistent, Lazy, None.<br>   - `included_paths` : (Optional) List of paths to include in the indexing. Required if indexing\_mode is Consistent or Lazy.<br>   - `excluded_paths` : (Optional) List of paths to exclude from indexing. Required if indexing\_mode is Consistent or Lazy.<br>   - `composite_indexes` : (Optional) One or more composite\_index blocks as defined below.<br>     - `indexes` : An index block supports the following<br>       - `index_path` : (Required) Path for which the indexing behaviour applies to.<br>       - `index_order` : (Required) Order of the index. Possible values are Ascending or Descending.<br>   - `spatial_indexes` : (Optional) One or more spatial\_index blocks as defined below.<br>     - `spatial_index_path` : (Required) Path for which the indexing behaviour applies to. According to the service design, all spatial types including LineString, MultiPolygon, Point, and Polygon will be applied to the path. | <pre>map(object({<br>    graph_name            = string<br>    db_name               = string<br>    partition_key_path    = string<br>    partition_key_version = optional(number)<br>    default_ttl_seconds   = optional(string)<br>    graph_throughput      = optional(number)<br>    graph_max_throughput  = optional(number)<br>    index_policy_settings = object({<br>      indexing_automatic = optional(bool)<br>      indexing_mode      = string<br>      included_paths     = optional(list(string))<br>      excluded_paths     = optional(list(string))<br>      composite_indexes = optional(map(object({<br>        indexes = set(object({<br>          index_path  = string<br>          index_order = string<br>        }))<br>      })))<br>      spatial_indexes = optional(map(object({<br>        spatial_index_path = string<br>      })))<br>    })<br>    conflict_resolution_policy = object({<br>      mode      = string<br>      path      = string<br>      procedure = string<br>    })<br>    unique_key = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_ip_firewall_enabled"></a> [ip\_firewall\_enabled](#input\_ip\_firewall\_enabled) | Enable ip firewwall to allow connection to this cosmosdb from client's machine and from azure portal. | `bool` | `true` | no |
| <a name="input_is_virtual_network_filter_enabled"></a> [is\_virtual\_network\_filter\_enabled](#input\_is\_virtual\_network\_filter\_enabled) | Enables virtual network filtering for this Cosmos DB account | `bool` | `false` | no |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | Name of the existing key in key vault. It is needed for encryption using customer managed key. | `string` | `null` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Name of the existing key vault. It is needed for encryption using customer managed key. | `string` | `null` | no |
| <a name="input_key_vault_rg_name"></a> [key\_vault\_rg\_name](#input\_key\_vault\_rg\_name) | Name of the resource group in which key vault exists. | `string` | `null` | no |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | (Optional) Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication. Defaults to false. Can be set only when using the SQL API. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Describe the deployment location | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The resource id of log analytics workspace | `string` | n/a | yes |
| <a name="input_minimal_tls_version"></a> [minimal\_tls\_version](#input\_minimal\_tls\_version) | (Optional) Specifies the minimal TLS version for the CosmosDB account. Possible values are: `Tls`, `Tls11`, and `Tls12`. | `string` | `"Tls12"` | no |
| <a name="input_mongo_db_collections"></a> [mongo\_db\_collections](#input\_mongo\_db\_collections) | List of Cosmos DB Mongo collections to create. Some parameters are inherited from cosmos account.<br>  `collection_name` : Specifies the name of the Cosmos DB Mongo Collection. <br>  `db_name` : Specifies the name of the Cosmos DB Mongo Database.<br>  `default_ttl_seconds` : (Optional) The default Time To Live in seconds. If the value is -1, items are not automatically expired.<br>  `shard_key` : (Optional) The name of the key to partition on for sharding. There must not be any other unique index keys.<br>  `collection_throughout` : (Optional) The throughput of the MongoDB collection (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>  `collection_max_throughput` : (Optional) The maximum throughput of the MongoDB collection (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br>  `analytical_storage_ttl` : (Optional) The default time to live of Analytical Storage for this Mongo Collection. If present and the value is set to -1, it is equal to infinity, and items don’t expire by default. If present and the value is set to some number n – items will expire n seconds after their last modified time.<br>  `indexes` : The index block supports the following<br>   - `mongo_index_keys` : (Required) Specifies the list of user settable keys for each Cosmos DB Mongo Collection.<br>   - `mongo_index_unique` : (Optional) Is the index unique or not? Defaults to false.<br>    > Note: An index with an "\_id" key must be specified. | <pre>map(object({<br>    collection_name           = string<br>    db_name                   = string<br>    default_ttl_seconds       = optional(string)<br>    shard_key                 = optional(string)<br>    collection_throughout     = optional(number)<br>    collection_max_throughput = optional(number)<br>    analytical_storage_ttl    = optional(number)<br>    indexes = map(object({<br>      mongo_index_keys   = list(string)<br>      mongo_index_unique = bool<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_mongo_dbs"></a> [mongo\_dbs](#input\_mongo\_dbs) | Map of Cosmos DB Mongo DBs to create. Some parameters are inherited from cosmos account.<br>  `db_name` : Specifies the name of the Cosmos DB Mongo Database.<br>  `db_throughput` : (Optional) The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>  > Note: throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support.<br>  `db_max_throughput` : (Optional) The maximum throughput of the MongoDB database (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput. | <pre>map(object({<br>    db_name           = string<br>    db_throughput     = optional(number)<br>    db_max_throughput = optional(number)<br>  }))</pre> | `{}` | no |
| <a name="input_mongo_server_version"></a> [mongo\_server\_version](#input\_mongo\_server\_version) | (Optional) The Server Version of a MongoDB account. Possible values are `4.2`, `4.0`, `3.6`, and `3.2`. | `string` | `"4.2"` | no |
| <a name="input_network_acl_bypass_for_azure_services"></a> [network\_acl\_bypass\_for\_azure\_services](#input\_network\_acl\_bypass\_for\_azure\_services) | If azure services can bypass ACLs. | `bool` | `false` | no |
| <a name="input_network_acl_bypass_ids"></a> [network\_acl\_bypass\_ids](#input\_network\_acl\_bypass\_ids) | The list of resource Ids for Network Acl Bypass for this Cosmos DB account. | `list(string)` | `null` | no |
| <a name="input_partition_merge_enabled"></a> [partition\_merge\_enabled](#input\_partition\_merge\_enabled) | (Optional) Is partition merge on the Cosmos DB account enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_pe_subresource"></a> [pe\_subresource](#input\_pe\_subresource) | Map of subresources to choose appropriate Private Endpoint sub resource for DB API | `map(any)` | <pre>{<br>  "cassandra": "Cassandra",<br>  "gremlin": "Gremlin",<br>  "mongo": "MongoDB",<br>  "sql": "SQL",<br>  "table": "Table"<br>}</pre> | no |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Map of the private DNS zone to choose approrite Private DNS Zone for DB API. | `map(any)` | <pre>{<br>  "cassandra": "privatelink.cassandra.cosmos.azure.com",<br>  "gremlin": "privatelink.gremlin.cosmos.azure.com",<br>  "mongo": "privatelink.mongo.cosmos.azure.com",<br>  "sql": "privatelink.documents.azure.com",<br>  "table": "privatelink.table.cosmos.azure.com"<br>}</pre> | no |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | Parameters for private endpoint creation<br>  `name` - (Required) Specifies the Name of the Private Endpoint.<br>  `vnet_rg_name` - (Required) Specifies the Name of the Virtual Network Resource Group.<br>  `vnet_name` - (Required) Specifies the Name of the Virtual Network.<br>  `subnet_name` - (Required) Specifies the Name of the Private Endpoitn Subnet.<br>  `dns_zone_rg_name` - (Required) Specifies the Name of the DNS Zone Resource Group.<br>  `enable_private_dns_entry` - (Required) Whether to enable Private DNS Entry?<br>  `dns_zone_group_name` - (Optional) Specifies the Name of the Private DNS Zone Group.<br>  `private_service_connection_name` - (Optional) Specifies the Name of the Private Service Connection.<br>  `is_manual_connection` - (Required) Does the Private Endpoint require Manual Approval from the remote resource owner? | <pre>map(object({<br>    name                            = string<br>    vnet_rg_name                    = string<br>    vnet_name                       = string<br>    subnet_name                     = string<br>    dns_zone_rg_name                = string<br>    enable_private_dns_entry        = bool<br>    dns_zone_group_name             = optional(string)<br>    private_service_connection_name = optional(string)<br>    is_manual_connection            = bool<br>  }))</pre> | `{}` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this CosmosDB account. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | n/a | yes |
| <a name="input_sql_db_containers"></a> [sql\_db\_containers](#input\_sql\_db\_containers) | List of Cosmos DB SQL Containers to create. Some parameters are inherited from cosmos account.<br>  `container_name` : Specifies the name of the Cosmos DB SQL Container.<br>  `db_name` : Specifies the name of the Cosmos DB SQL Database.<br>  `partition_key_paths` : (Required) A list of partition key paths.<br>  `partition_key_version` : (Optional) Define a partition key version. Possible values are 1and 2. This should be set to 2 in order to use large partition keys.<br>  `container_throughout` : (Optional) The throughput of SQL container (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon container creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>  `container_max_throughput` : (Optional) The maximum throughput of the SQL container (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br>  `default_ttl` : (Optional) The default time to live of SQL container. If missing, items are not expired automatically. If present and the value is set to -1, it is equal to infinity, and items don't expire by default. If present and the value is set to some number n - items will expire n seconds after their last modified time.<br>  `analytical_storage_ttl` : (Optional) The default time to live of Analytical Storage for this SQL container. If present and the value is set to -1, it is equal to infinity, and items don't expire by default. If present and the value is set to some number n - items will expire n seconds after their last modified time.<br>  `indexing_policy_settings` : An indexing\_policy\_settings block supports the following<br>   - `sql_indexing_mode` : Indicates the indexing mode. Possible values include: consistent and none.<br>   - `sql_included_path` : (Optional) One or more included\_path blocks as defined below. Either included\_path or excluded\_path must contain the path /*<br>   - `sql_excluded_path` : (Optional) One or more excluded\_path blocks as defined below. Either included\_path or excluded\_path must contain the path /*<br>   - `composite_index` : (Optional) One or more composite\_index blocks as defined below.<br>   - `indexes` :  (Required) One or more index blocks as defined below.<br>      - `path` : (Required) Path for which the indexing behaviour applies to.<br>      - `order` : (Required) Order of the index. Possible values are Ascending or Descending.<br>   - `spatial_index` : (Optional) One or more spatial\_index blocks as defined below.<br>      - `path` : (Required) Path for which the indexing behaviour applies to. According to the service design, all spatial types including LineString, MultiPolygon, Point, and Polygon will be applied to the path.<br>   - `sql_unique_key` : A list of paths to use for this unique key.<br>   - `conflict_resolution_policy` : A conflict\_resolution\_policy block supports the following<br>    - `mode` : (Required) Indicates the conflict resolution mode. Possible values include: LastWriterWins, Custom.<br>    - `conflict_resolution_path` : (Optional) The conflict resolution path in the case of LastWriterWins mode.<br>    - `procedure` : (Optional) The procedure to resolve conflicts in the case of Custom mode. | <pre>map(object({<br>    container_name           = string<br>    db_name                  = string<br>    partition_key_paths      = list(string)<br>    partition_key_version    = optional(number)<br>    container_throughout     = optional(number)<br>    container_max_throughput = optional(number)<br>    default_ttl              = optional(number)<br>    analytical_storage_ttl   = optional(number)<br>    indexing_policy_settings = object({<br>      sql_indexing_mode = optional(string)<br>      sql_included_path = optional(string)<br>      sql_excluded_path = optional(string)<br>      composite_indexes = optional(map(object({<br>        indexes = set(object({<br>          path  = string<br>          order = string<br>        }))<br>      })))<br>      spatial_indexes = optional(map(object({<br>        path = string<br>      })))<br>    })<br>    sql_unique_key = list(string)<br>    conflict_resolution_policy = object({<br>      mode      = string<br>      path      = string<br>      procedure = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_sql_dbs"></a> [sql\_dbs](#input\_sql\_dbs) | Map of Cosmos DB SQL DBs to create. Some parameters are inherited from cosmos account.<br>  `db_name` : Specifies the name of the Cosmos DB SQL Database.<br>  `db_throughput` : The throughput of SQL database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. Do not set when azurerm\_cosmosdb\_account is configured with EnableServerless capability.<br>  > Note: Throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support<br>  `db_max_throughput` : The maximum throughput of the SQL database (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput. | <pre>map(object({<br>    db_name           = string<br>    db_throughput     = number<br>    db_max_throughput = number<br>  }))</pre> | `{}` | no |
| <a name="input_tables"></a> [tables](#input\_tables) | Map of Cosmos DB Tables to create. Some parameters are inherited from cosmos account.<br>  `table_name` - Specifies the name of the Cosmos DB Table.<br>  `table_throughput` - The throughput of Table (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br>  `table_max_throughput` - (Optional) The maximum throughput of the Table (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br>  > Note `throughput` has a maximum value of 1000000 unless a higher limit is requested via Azure Support | <pre>map(object({<br>    table_name           = string<br>    table_throughput     = number<br>    table_max_throughput = number<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags with the following required keys:<br>- ApplicationSupportDL (must be a valid email address)<br>- BudgetOwner (must be a valid email address)<br>- Budget<br>- CostOwner (must be a valid email address)<br>- Country<br>- DeploymentType<br>- FinanceSpoc (must be a valid email address)<br>- ProjectName<br>- ProjectOwner (must be a valid email address)<br>- ProjectOwnerSupervisor (must be a valid email address)<br>- Region<br>- SDTicketNo<br>- SubsidiaryDepartment<br>- SubsidiaryName<br>- Vertical | `map(string)` | n/a | yes |
| <a name="input_virtual_network_rule"></a> [virtual\_network\_rule](#input\_virtual\_network\_rule) | Specifies a virtual\_network\_rules resource used to define which subnets are allowed to access this CosmosDB account.<br>  `id` - (Required) The ID of the virtual network subnet.<br>  `ignore_missing_vnet_service_endpoint` - (Optional) If set to true, the specified subnet will be added as a virtual network rule even if its CosmosDB service endpoint is not active. | <pre>list(object({<br>    id                                   = string,<br>    ignore_missing_vnet_service_endpoint = optional(bool)<br>  }))</pre> | `null` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | True to enabled zone redundancy on default primary location | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cassandra_keyspace_id"></a> [cassandra\_keyspace\_id](#output\_cassandra\_keyspace\_id) | Cassandra API Keyspace IDs |
| <a name="output_cassandra_table_id"></a> [cassandra\_table\_id](#output\_cassandra\_table\_id) | Cassandra API Table IDs |
| <a name="output_cosmosdb_connection_strings"></a> [cosmosdb\_connection\_strings](#output\_cosmosdb\_connection\_strings) | Cosmos DB Connection Strings |
| <a name="output_cosmosdb_endpoint"></a> [cosmosdb\_endpoint](#output\_cosmosdb\_endpoint) | Cosmos DB Endpoint |
| <a name="output_cosmosdb_id"></a> [cosmosdb\_id](#output\_cosmosdb\_id) | Cosmos DB Account ID |
| <a name="output_cosmosdb_primary_key"></a> [cosmosdb\_primary\_key](#output\_cosmosdb\_primary\_key) | Cosmos DB Primary Keys |
| <a name="output_cosmosdb_primary_readonly_key"></a> [cosmosdb\_primary\_readonly\_key](#output\_cosmosdb\_primary\_readonly\_key) | Cosmos DB Primary Read Only Keys |
| <a name="output_cosmosdb_read_endpoint"></a> [cosmosdb\_read\_endpoint](#output\_cosmosdb\_read\_endpoint) | Cosmos DB Read Endpoint |
| <a name="output_cosmosdb_secondary_key"></a> [cosmosdb\_secondary\_key](#output\_cosmosdb\_secondary\_key) | Cosmos DB Secondary Keys |
| <a name="output_cosmosdb_secondary_readonly_key"></a> [cosmosdb\_secondary\_readonly\_key](#output\_cosmosdb\_secondary\_readonly\_key) | Cosmos DB Secondary Read Only Keys |
| <a name="output_cosmosdb_systemassigned_identity"></a> [cosmosdb\_systemassigned\_identity](#output\_cosmosdb\_systemassigned\_identity) | Cosmos DB System Assigned Identity (Tenant ID and Principal ID) |
| <a name="output_cosmosdb_write_endpoint"></a> [cosmosdb\_write\_endpoint](#output\_cosmosdb\_write\_endpoint) | Cosmos DB Write Endpoint |
| <a name="output_gremlin_db_id"></a> [gremlin\_db\_id](#output\_gremlin\_db\_id) | Gremlin API DB IDs |
| <a name="output_gremlin_graph_id"></a> [gremlin\_graph\_id](#output\_gremlin\_graph\_id) | Gremlin API Graph IDs |
| <a name="output_mongo_db_collection_id"></a> [mongo\_db\_collection\_id](#output\_mongo\_db\_collection\_id) | Mongo API Collection IDs |
| <a name="output_mongo_db_id"></a> [mongo\_db\_id](#output\_mongo\_db\_id) | Mongo API DB IDs |
| <a name="output_sql_containers_id"></a> [sql\_containers\_id](#output\_sql\_containers\_id) | SQL API Container IDs |
| <a name="output_sql_db_id"></a> [sql\_db\_id](#output\_sql\_db\_id) | SQL API DB IDs |
| <a name="output_table_id"></a> [table\_id](#output\_table\_id) | Table API Table IDs |
