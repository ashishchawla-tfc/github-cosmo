/* Gremlin API Variables*/
variable "gremlin_dbs" {
  description = <<EOD
Map of Cosmos DB Gremlin DBs to create. Some parameters are inherited from cosmos account.
`db_name` : Specifies the name of the Cosmos DB Gremlin Database.
`db_throughput` : (Optional) The throughput of the Gremlin database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
> Note: throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support
`db_max_throughput` : (Optional) The maximum throughput of the Gremlin database (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
EOD
  type = map(object({
    db_name           = string
    db_throughput     = optional(number)
    db_max_throughput = optional(number)
  }))
  default = {}
}

variable "gremlin_graphs" {
  description = <<EOD
List of Cosmos DB Gremlin Graph to create. Some parameters are inherited from cosmos account.
`graph_name` : Specifies the name of the Cosmos DB Gremlin Graph.
`db_name` : Specifies the name of the Cosmos DB Gremlin Database.
`partition_key_path` : (Required) Define a partition key.
`partition_key_version` : (Optional) Define a partition key version. Changing this forces a new resource to be created. Possible values are 1and 2. This should be set to 2 in order to use large partition keys.
`default_ttl_seconds` : (Optional) The default time to live (TTL) of the Gremlin graph. If the value is missing or set to "-1", items don't expire.
`graph_throughput` : (Optional) The throughput of the Gremlin graph (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
`graph_max_throughput` : (Optional) The maximum throughput of the Gremlin graph (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
`index_policy_settings` : An index_policy block supports the following
  - `indexing_automatic` : (Optional) Indicates if the indexing policy is automatic. Defaults to true.
  - `indexing_mode` : (Required) Indicates the indexing mode. Possible values include: Consistent, Lazy, None.
  - `included_paths` : (Optional) List of paths to include in the indexing. Required if indexing_mode is Consistent or Lazy.
  - `excluded_paths` : (Optional) List of paths to exclude from indexing. Required if indexing_mode is Consistent or Lazy.
  - `composite_indexes` : (Optional) One or more composite_index blocks as defined below.
    - `indexes` : An index block supports the following
      - `index_path` : (Required) Path for which the indexing behaviour applies to.
      - `index_order` : (Required) Order of the index. Possible values are Ascending or Descending.
  - `spatial_indexes` : (Optional) One or more spatial_index blocks as defined below.
    - `spatial_index_path` : (Required) Path for which the indexing behaviour applies to. According to the service design, all spatial types including LineString, MultiPolygon, Point, and Polygon will be applied to the path.
EOD
  type = map(object({
    graph_name            = string
    db_name               = string
    partition_key_path    = string
    partition_key_version = optional(number)
    default_ttl_seconds   = optional(string)
    graph_throughput      = optional(number)
    graph_max_throughput  = optional(number)
    index_policy_settings = object({
      indexing_automatic = optional(bool)
      indexing_mode      = string
      included_paths     = optional(list(string))
      excluded_paths     = optional(list(string))
      composite_indexes = optional(map(object({
        indexes = set(object({
          index_path  = string
          index_order = string
        }))
      })))
      spatial_indexes = optional(map(object({
        spatial_index_path = string
      })))
    })
    conflict_resolution_policy = object({
      mode      = string
      path      = string
      procedure = string
    })
    unique_key = list(string)
  }))
  default = {}
}