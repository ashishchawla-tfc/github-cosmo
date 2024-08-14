variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  type        = bool
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  type        = string
}

variable "location" {
  description = "Describe the deployment location"
  type        = string
  validation {
    condition     = contains(["northeurope", "westus2", "brazilsouth", "eastus", "centralindia", "germanywestcentral", "southeastasia", "westus3", "uksouth", "global", "australiaeast"], var.location)
    error_message = "Valid value is one of the following: northeurope, westus2, brazilsouth, eastus, centralindia, germanywestcentral, southeastasia, westus3, uksouth, global, australiaeast."
  }
}

variable "cosmos_account_name" {
  description = "Specifies the name of the CosmosDB Account."
  type        = string
}

variable "cosmos_api" {
  description = "Specifies the name of Cosmos API."
  type        = string
  validation {
    condition     = contains(["sql", "table", "cassandra", "mongo", "gremlin"], lower(var.cosmos_api))
    error_message = "Unsupported cosmos api specified. Supported APIs include sql, table, cassandra, mongo and gremlin."
  }
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this CosmosDB account."
  type        = bool
  default     = false
}

variable "ip_firewall_enabled" {
  description = "Enable ip firewwall to allow connection to this cosmosdb from client's machine and from azure portal."
  type        = bool
  default     = true
}

variable "firewall_ip" {
  description = "List of ip address to allow access from the internet or on-premisis network."
  type        = list(string)
  default     = []
}

variable "azure_portal_access" {
  description = "List of ip address to enable the Allow access from the Azure portal behavior."
  type        = list(string)
  default     = ["104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"]
}

variable "azure_dc_access" {
  description = "List of ip address to enable the Accept connections from within public Azure datacenters behavior."
  type        = list(string)
  default     = ["0.0.0.0"]
}

variable "minimal_tls_version" {
  description = "(Optional) Specifies the minimal TLS version for the CosmosDB account. Possible values are: `Tls`, `Tls11`, and `Tls12`."
  type        = string
  default     = "Tls12"
}

variable "automatic_failover_enabled" {
  description = "(Optional) Enable automatic failover for this Cosmos DB account."
  type        = bool
  default     = false
}

variable "mongo_server_version" {
  description = "(Optional) The Server Version of a MongoDB account. Possible values are `4.2`, `4.0`, `3.6`, and `3.2`."
  type        = string
  default     = "4.2"
}
variable "partition_merge_enabled" {
  description = "(Optional) Is partition merge on the Cosmos DB account enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "local_authentication_disabled" {
  description = "(Optional) Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication. Defaults to false. Can be set only when using the SQL API."
  type        = bool
  default     = false
}
variable "free_tier_enabled" {
  description = "Enable the option to opt-in for the free database account within subscription."
  type        = bool
  default     = false
}

variable "enable_multiple_write_locations" {
  description = "Enable multiple write locations for this Cosmos DB account."
  type        = bool
  default     = false
}

variable "key_vault_name" {
  description = "Name of the existing key vault. It is needed for encryption using customer managed key."
  type        = string
  default     = null
}

variable "key_vault_rg_name" {
  description = "Name of the resource group in which key vault exists."
  type        = string
  default     = null
}

variable "key_vault_key_name" {
  description = "Name of the existing key in key vault. It is needed for encryption using customer managed key."
  type        = string
  default     = null
}

variable "is_virtual_network_filter_enabled" {
  description = "Enables virtual network filtering for this Cosmos DB account"
  type        = bool
  default     = false
}

variable "network_acl_bypass_for_azure_services" {
  description = "If azure services can bypass ACLs."
  type        = bool
  default     = false
}

variable "network_acl_bypass_ids" {
  description = "The list of resource Ids for Network Acl Bypass for this Cosmos DB account."
  type        = list(string)
  default     = null
}

variable "consistency_policy_level" {
  description = "Consistency policy level. Allowed values are `BoundedStaleness`, `Eventual`, `Session`, `Strong` or `ConsistentPrefix`"
  type        = string
  default     = "BoundedStaleness"
}

variable "consistency_policy_max_interval_in_seconds" {
  description = "When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency_level is set to BoundedStaleness."
  type        = number
  default     = 10
}

variable "consistency_policy_max_staleness_prefix" {
  description = "When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency_level is set to BoundedStaleness."
  type        = number
  default     = 200
}

variable "capacity_total_throughput_limit" {
  description = "(Required) The total throughput limit imposed on this Cosmos DB account (RU/s). Possible values are at least `-1`. `-1` means no limit."
  type        = string
  default     = "-1"
}

variable "capabilities" {
  description = "Map of non-sql DB API to enable support for API other than SQL"
  type        = map(any)
  default = {
    sql       = "SQL"
    table     = "EnableTable"
    gremlin   = "EnableGremlin"
    mongo     = "EnableMongo"
    cassandra = "EnableCassandra"
  }
}

variable "additional_capabilities" {
  description = "List of additional capabilities for Cosmos DB API. - possible options are DisableRateLimitingResponses, EnableAggregationPipeline, EnableServerless, mongoEnableDocLevelTTL, MongoDBv3.4, AllowSelfServeUpgradeToMongo36"
  type        = list(string)
  default     = []
}

variable "failover_locations" {
  description = <<EOD
The name of the Azure region to host replicated data and their priority.
Configures the geographic locations the data is replicated to and supports the following
`location` : The name of the Azure region to host replicated data.
`failover_priority` : The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. Changing this causes the location to be re-provisioned and cannot be changed for the location with failover priority 0.
`zone_redundant` : Should zone redundancy be enabled for this region?
EOD
  type        = map(map(string))
  default     = null
}

variable "zone_redundancy_enabled" {
  description = "True to enabled zone redundancy on default primary location"
  type        = bool
  default     = true
}

variable "backup_enabled" {
  type        = bool
  description = "Enable backup for this Cosmos DB account"
  default     = true
}

variable "backup_type" {
  type        = string
  description = "Type of backup - can be either Periodic or Continuous"
  default     = "periodic"
}

variable "backup_tier" {
  description = "(Optional) The continuous backup tier. Possible values are `Continuous7Days` and `Continuous30Days`."
  type        = string
  default     = "Continuous7Days"
}

variable "backup_interval" {
  type        = string
  description = "The interval in minutes between two backups. This is configurable only when type is Periodic. Possible values are between 60 and 1440."
  default     = 60
}

variable "backup_retention" {
  type        = string
  description = "The time in hours that each backup is retained. This is configurable only when type is Periodic. Possible values are between 8 and 720."
  default     = 8
}

variable "backup_storage_redundancy" {
  type        = string
  description = "The storage redundancy which is used to indicate type of backup residency. This is configurable only when type is Periodic. Possible values are Geo, Local and Zone"
  default     = "Geo"
}

variable "create_mode" {
  description = " (Optional) The creation mode for the CosmosDB Account. Possible values are `Default` and `Restore`. `Note:` `create_mode` can only be defined when the backup.type is set to `Continuous`."
  type        = string
  default     = "Default"
}

variable "analytical_storage" {
  description = <<EOD
Analytical storage enablement.
`enabled` : Enable Analytical Storage option for this Cosmos DB account.
`schema_type` : The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`.
EOD
  type = object({
    enabled     = bool
    schema_type = string
  })
  default = {
    enabled     = false
    schema_type = null
  }
}

variable "virtual_network_rule" {
  description = <<EOD
Specifies a virtual_network_rules resource used to define which subnets are allowed to access this CosmosDB account.
`id` : (Required) The ID of the virtual network subnet.
`ignore_missing_vnet_service_endpoint` : (Optional) If set to true, the specified subnet will be added as a virtual network rule even if its CosmosDB service endpoint is not active.
EOD
  type = list(object({
    id                                   = string,
    ignore_missing_vnet_service_endpoint = optional(bool)
  }))
  default = null
}

variable "cors_rule" {
  description = <<EOD
A cors_rule block supports the following
`allowed_headers` : (Required) A list of headers that are allowed to be a part of the cross-origin request.
`allowed_methods` : (Required) A list of HTTP headers that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
`allowed_origins` : (Required) A list of origin domains that will be allowed by CORS.
`exposed_headers` : (Required) A list of response headers that are exposed to CORS clients.
`max_age_in_seconds` : (Optional) The number of seconds the client should cache a preflight response. Possible values are between 1 and 2147483647.
EOD
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = optional(number)
  }))
  default = null
}

variable "enable_systemassigned_identity" {
  type        = bool
  description = "Enable System Assigned Identity"
  default     = false
}

variable "tables" {
  description = <<EOD
Map of Cosmos DB Tables to create. Some parameters are inherited from cosmos account.
`table_name` : Specifies the name of the Cosmos DB Table.
`table_throughput` : The throughput of Table (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
`table_max_throughput` : (Optional) The maximum throughput of the Table (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
> Note: `throughput` has a maximum value of 1000000 unless a higher limit is requested via Azure Support
EOD
  type = map(object({
    table_name           = string
    table_throughput     = number
    table_max_throughput = number
  }))
  default = {}
}

# Private endpoint variables 
variable "private_endpoint" {
  description = <<EOD
Parameters for private endpoint creation
`name` : (Required) Specifies the Name of the Private Endpoint.
`vnet_rg_name` : (Required) Specifies the Name of the Virtual Network Resource Group.
`vnet_name` : (Required) Specifies the Name of the Virtual Network.
`subnet_name` : (Required) Specifies the Name of the Private Endpoitn Subnet.
`dns_zone_rg_name` : (Required) Specifies the Name of the DNS Zone Resource Group.
`enable_private_dns_entry` : (Required) Whether to enable Private DNS Entry?
`dns_zone_group_name` : (Optional) Specifies the Name of the Private DNS Zone Group.
`private_service_connection_name` : (Optional) Specifies the Name of the Private Service Connection.
`is_manual_connection` : (Required) Does the Private Endpoint require Manual Approval from the remote resource owner?
EOD
  type = map(object({
    name                            = string
    vnet_rg_name                    = string
    vnet_name                       = string
    subnet_name                     = string
    dns_zone_rg_name                = string
    enable_private_dns_entry        = bool
    dns_zone_group_name             = optional(string)
    private_service_connection_name = optional(string)
    is_manual_connection            = bool
  }))
  default = {}
}

variable "pe_subresource" {
  description = "Map of subresources to choose appropriate Private Endpoint sub resource for DB API"
  type        = map(any)
  default = {
    sql       = "SQL"
    table     = "Table"
    gremlin   = "Gremlin"
    mongo     = "MongoDB"
    cassandra = "Cassandra"
  }
}

variable "private_dns_zone_name" {
  description = "Map of the private DNS zone to choose approrite Private DNS Zone for DB API."
  type        = map(any)
  default = {
    sql       = "privatelink.documents.azure.com"
    table     = "privatelink.table.cosmos.azure.com"
    gremlin   = "privatelink.gremlin.cosmos.azure.com"
    mongo     = "privatelink.mongo.cosmos.azure.com"
    cassandra = "privatelink.cassandra.cosmos.azure.com"
  }
}

variable "tags" {
  type        = map(string)
  description = <<EOT
A map of tags with the following required keys:
- ApplicationSupportDL (must be a valid email address)
- BudgetOwner (must be a valid email address)
- Budget
- CostOwner (must be a valid email address)
- Country
- DeploymentType
- FinanceSpoc (must be a valid email address)
- ProjectName
- ProjectOwner (must be a valid email address)
- ProjectOwnerSupervisor (must be a valid email address)
- Region
- SDTicketNo
- SubsidiaryDepartment
- SubsidiaryName
- Vertical
EOT

  validation {
    condition = alltrue([
      contains(keys(var.tags), "ApplicationSupportDL"),
      contains(keys(var.tags), "BudgetOwner"),
      contains(keys(var.tags), "Budget"),
      contains(keys(var.tags), "CostOwner"),
      contains(keys(var.tags), "Country"),
      contains(keys(var.tags), "DeploymentType"),
      contains(keys(var.tags), "FinanceSpoc"),
      contains(keys(var.tags), "ProjectName"),
      contains(keys(var.tags), "ProjectOwner"),
      contains(keys(var.tags), "ProjectOwnerSupervisor"),
      contains(keys(var.tags), "Region"),
      contains(keys(var.tags), "SDTicketNo"),
      contains(keys(var.tags), "SubsidiaryDepartment"),
      contains(keys(var.tags), "SubsidiaryName"),
      contains(keys(var.tags), "Vertical"),
      length(var.tags["ApplicationSupportDL"]) > 0,
      length(var.tags["BudgetOwner"]) > 0,
      length(var.tags["Budget"]) > 0,
      length(var.tags["CostOwner"]) > 0,
      length(var.tags["Country"]) > 0,
      length(var.tags["DeploymentType"]) > 0,
      length(var.tags["FinanceSpoc"]) > 0,
      length(var.tags["ProjectName"]) > 0,
      length(var.tags["ProjectOwner"]) > 0,
      length(var.tags["ProjectOwnerSupervisor"]) > 0,
      length(var.tags["Region"]) > 0,
      length(var.tags["SDTicketNo"]) > 0,
      length(var.tags["SubsidiaryDepartment"]) > 0,
      length(var.tags["SubsidiaryName"]) > 0,
      length(var.tags["Vertical"]) > 0
    ])

    error_message = "The tags map must contain the following keys with non-empty values: ApplicationSupportDL, BudgetOwner, CostCode, CostOwner, Country, DeploymentType, FinanceSpoc, ProjectName, ProjectOwner, ProjectOwnerSupervisor, Region, SDTicketNo, SubsidiaryDepartment, SubsidiaryName, and Vertical. Additionally, none of the values can be empty."
  }
}

variable "enable_diagnostic_settings" {
  description = "Whether to configure Diagnostic settings for Azure Kubernetes Service."
  type        = bool
}

variable "log_analytics_workspace_id" {
  description = "The resource id of log analytics workspace"
  type        = string
}