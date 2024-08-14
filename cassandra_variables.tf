/* Cassandra API Variables*/
variable "cassandra_keyspaces" {
  description = <<EOD
List of Cosmos DB Cassandra keyspaces to create. Some parameters are inherited from cosmos account.
`keyspace_name` : Specifies the name of the Cosmos DB Cassandra KeySpace.
`keyspace_throughput` : (Optional) The throughput of Cassandra KeySpace (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
  >  Note: throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support
`keyspace_max_throughput` : (Optional) The maximum throughput of the Cassandra KeySpace (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
EOD
  type = map(object({
    keyspace_name           = string
    keyspace_throughput     = optional(number)
    keyspace_max_throughput = optional(number)
  }))
  default = {}
}

variable "cassandra_tables" {
  description = <<EOD
List of Cosmos DB Cassandra tables to create. Some parameters are inherited from cosmos account.
`table_name` : Specifies the name of the Cosmos DB Cassandra Table.
`keyspace_name` : Specifies the name of the Cosmos DB Cassandra KeySpace.
`default_ttl_seconds` : (Optional) Time to live of the Cosmos DB Cassandra table. Possible values are at least -1. -1 means the Cassandra table never expires.
`analytical_storage_ttl` : (Optional) Time to live of the Analytical Storage. Possible values are between -1 and 2147483647 except 0. -1 means the Analytical Storage never expires. Changing this forces a new resource to be created.
`table_throughout` : (Optional) The throughput of Cassandra KeySpace (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
`table_max_throughput` : (Optional) The maximum throughput of the Cassandra Table (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
`cassandra_schema_settings` : A cassandra_schema_settings block supports the following
  - `column` : (Required) One or more column blocks as defined below.
    - `column_key_name` : (Required) Name of the column to be created.
    - `column_key_type` : (Required) Type of the column to be created.
  - `partition_key` : (Required) One or more partition_key blocks as defined below.
    - `partition_key_name` : (Required) Name of the column to partition by.
  - `cluster_key` : (Optional) One or more cluster_key blocks as defined below.
    - `cluster_key_name` : (Required) Name of the cluster key to be created.
    - `cluster_key_order_by` : (Required) Order of the key. Currently supported values are Asc and Desc.
EOD
  type = map(object({
    table_name             = string
    keyspace_name          = string
    default_ttl_seconds    = optional(string)
    analytical_storage_ttl = optional(number)
    table_throughout       = optional(number)
    table_max_throughput   = optional(number)
    cassandra_schema_settings = object({
      column = map(object({
        column_key_name = string
        column_key_type = string
      }))
      partition_key = map(object({
        partition_key_name = string
      }))
      cluster_key = map(object({
        cluster_key_name     = string
        cluster_key_order_by = string
      }))
    })
  }))
  default = {}
}