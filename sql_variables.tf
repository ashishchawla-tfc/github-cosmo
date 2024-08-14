/* SQL API Variables*/
variable "sql_dbs" {
  description = <<EOD
Map of Cosmos DB SQL DBs to create. Some parameters are inherited from cosmos account.
`db_name` : Specifies the name of the Cosmos DB SQL Database.
`db_throughput` : The throughput of SQL database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. Do not set when azurerm_cosmosdb_account is configured with EnableServerless capability.
> Note: Throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support
`db_max_throughput` : The maximum throughput of the SQL database (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
EOD
  type = map(object({
    db_name           = string
    db_throughput     = number
    db_max_throughput = number
  }))
  default = {}
}

variable "sql_db_containers" {
  description = <<EOD
List of Cosmos DB SQL Containers to create. Some parameters are inherited from cosmos account.
`container_name` : Specifies the name of the Cosmos DB SQL Container.
`db_name` : Specifies the name of the Cosmos DB SQL Database.
`partition_key_paths` : (Required) A list of partition key paths.
`partition_key_version` : (Optional) Define a partition key version. Possible values are 1and 2. This should be set to 2 in order to use large partition keys.
`container_throughout` : (Optional) The throughput of SQL container (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon container creation otherwise it cannot be updated without a manual terraform destroy-apply.
`container_max_throughput` : (Optional) The maximum throughput of the SQL container (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
`default_ttl` : (Optional) The default time to live of SQL container. If missing, items are not expired automatically. If present and the value is set to -1, it is equal to infinity, and items don't expire by default. If present and the value is set to some number n - items will expire n seconds after their last modified time.
`analytical_storage_ttl` : (Optional) The default time to live of Analytical Storage for this SQL container. If present and the value is set to -1, it is equal to infinity, and items don't expire by default. If present and the value is set to some number n - items will expire n seconds after their last modified time.
`indexing_policy_settings` : An indexing_policy_settings block supports the following
  - `sql_indexing_mode` : Indicates the indexing mode. Possible values include: consistent and none.
  - `sql_included_path` : (Optional) One or more included_path blocks as defined below. Either included_path or excluded_path must contain the path /*
  - `sql_excluded_path` : (Optional) One or more excluded_path blocks as defined below. Either included_path or excluded_path must contain the path /*
  - `composite_index` : (Optional) One or more composite_index blocks as defined below.
  - `indexes` :  (Required) One or more index blocks as defined below.
    - `path` : (Required) Path for which the indexing behaviour applies to.
    - `order` : (Required) Order of the index. Possible values are Ascending or Descending.
  - `spatial_index` : (Optional) One or more spatial_index blocks as defined below.
    - `path` : (Required) Path for which the indexing behaviour applies to. According to the service design, all spatial types including LineString, MultiPolygon, Point, and Polygon will be applied to the path.
  - `sql_unique_key` : A list of paths to use for this unique key.
  - `conflict_resolution_policy` : A conflict_resolution_policy block supports the following
  - `mode` : (Required) Indicates the conflict resolution mode. Possible values include: LastWriterWins, Custom.
  - `conflict_resolution_path` : (Optional) The conflict resolution path in the case of LastWriterWins mode.
  - `procedure` : (Optional) The procedure to resolve conflicts in the case of Custom mode.
EOD
  type = map(object({
    container_name           = string
    db_name                  = string
    partition_key_paths      = list(string)
    partition_key_version    = optional(number)
    container_throughout     = optional(number)
    container_max_throughput = optional(number)
    default_ttl              = optional(number)
    analytical_storage_ttl   = optional(number)
    indexing_policy_settings = object({
      sql_indexing_mode = optional(string)
      sql_included_path = optional(string)
      sql_excluded_path = optional(string)
      composite_indexes = optional(map(object({
        indexes = set(object({
          path  = string
          order = string
        }))
      })))
      spatial_indexes = optional(map(object({
        path = string
      })))
    })
    sql_unique_key = list(string)
    conflict_resolution_policy = object({
      mode      = string
      path      = string
      procedure = string
    })
  }))
  default = {}
}