/* Mongo API Variables*/
variable "mongo_dbs" {
  description = <<EOD
Map of Cosmos DB Mongo DBs to create. Some parameters are inherited from cosmos account.
`db_name` : Specifies the name of the Cosmos DB Mongo Database.
`db_throughput` : (Optional) The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
> Note: throughput has a maximum value of 1000000 unless a higher limit is requested via Azure Support.
`db_max_throughput` : (Optional) The maximum throughput of the MongoDB database (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
EOD
  type = map(object({
    db_name           = string
    db_throughput     = optional(number)
    db_max_throughput = optional(number)
  }))
  default = {}
}

variable "mongo_db_collections" {
  description = <<EOD
List of Cosmos DB Mongo collections to create. Some parameters are inherited from cosmos account.
`collection_name` : Specifies the name of the Cosmos DB Mongo Collection. 
`db_name` : Specifies the name of the Cosmos DB Mongo Database.
`default_ttl_seconds` : (Optional) The default Time To Live in seconds. If the value is -1, items are not automatically expired.
`shard_key` : (Optional) The name of the key to partition on for sharding. There must not be any other unique index keys.
`collection_throughout` : (Optional) The throughput of the MongoDB collection (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.
`collection_max_throughput` : (Optional) The maximum throughput of the MongoDB collection (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
`analytical_storage_ttl` : (Optional) The default time to live of Analytical Storage for this Mongo Collection. If present and the value is set to -1, it is equal to infinity, and items don’t expire by default. If present and the value is set to some number n – items will expire n seconds after their last modified time.
`indexes` : The index block supports the following
  - `mongo_index_keys` : (Required) Specifies the list of user settable keys for each Cosmos DB Mongo Collection.
  - `mongo_index_unique` : (Optional) Is the index unique or not? Defaults to false.
  > Note: An index with an "_id" key must be specified.
EOD
  type = map(object({
    collection_name           = string
    db_name                   = string
    default_ttl_seconds       = optional(string)
    shard_key                 = optional(string)
    collection_throughout     = optional(number)
    collection_max_throughput = optional(number)
    analytical_storage_ttl    = optional(number)
    indexes = map(object({
      mongo_index_keys   = list(string)
      mongo_index_unique = bool
    }))
  }))
  default = {}
}