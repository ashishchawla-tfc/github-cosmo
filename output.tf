# Output account reference 
output "cosmosdb_id" {
  value       = azurerm_cosmosdb_account.main.id
  description = "Cosmos DB Account ID"
}

output "cosmosdb_endpoint" {
  value       = azurerm_cosmosdb_account.main.endpoint
  description = "Cosmos DB Endpoint"
}

output "cosmosdb_read_endpoint" {
  value       = azurerm_cosmosdb_account.main.read_endpoints
  description = "Cosmos DB Read Endpoint"
}

output "cosmosdb_write_endpoint" {
  value       = azurerm_cosmosdb_account.main.write_endpoints
  description = "Cosmos DB Write Endpoint"
}

output "cosmosdb_primary_key" {
  value       = azurerm_cosmosdb_account.main.primary_key
  sensitive   = true
  description = "Cosmos DB Primary Keys"
}

output "cosmosdb_secondary_key" {
  value       = azurerm_cosmosdb_account.main.secondary_key
  sensitive   = true
  description = "Cosmos DB Secondary Keys"
}

output "cosmosdb_primary_readonly_key" {
  value       = azurerm_cosmosdb_account.main.primary_readonly_key
  sensitive   = true
  description = "Cosmos DB Primary Read Only Keys"
}

output "cosmosdb_secondary_readonly_key" {
  value       = azurerm_cosmosdb_account.main.secondary_readonly_key
  sensitive   = true
  description = "Cosmos DB Secondary Read Only Keys"
}

output "cosmosdb_connection_strings" {
  value       = azurerm_cosmosdb_account.main.connection_strings
  sensitive   = true
  description = "Cosmos DB Connection Strings"
}

output "cosmosdb_systemassigned_identity" {
  value       = var.enable_systemassigned_identity ? zipmap(["tenant_id", "principal_id"], [azurerm_cosmosdb_account.main.identity[0].tenant_id, azurerm_cosmosdb_account.main.identity[0].principal_id]) : {}
  description = "Cosmos DB System Assigned Identity (Tenant ID and Principal ID)"
}

# Output SQL reference 
output "sql_db_id" {
  value       = [for sql_db_id in azurerm_cosmosdb_sql_database.main : zipmap([sql_db_id.name], [sql_db_id.id])]
  description = "SQL API DB IDs"
}

output "sql_containers_id" {
  value       = [for sql_container_id in azurerm_cosmosdb_sql_container.main : zipmap([sql_container_id.name], [sql_container_id.id])]
  description = "SQL API Container IDs"
}

# Output Cassandra reference 
output "cassandra_keyspace_id" {
  value       = [for cassandra_keyspace_id in azurerm_cosmosdb_cassandra_keyspace.main : zipmap([cassandra_keyspace_id.name], [cassandra_keyspace_id.id])]
  description = "Cassandra API Keyspace IDs"
}

output "cassandra_table_id" {
  value       = [for cassandra_table_id in azurerm_cosmosdb_cassandra_table.main : zipmap([cassandra_table_id.name], [cassandra_table_id.id])]
  description = "Cassandra API Table IDs"
}

# Output Gremlin reference 
output "gremlin_db_id" {
  value       = [for gremlin_db_id in azurerm_cosmosdb_gremlin_database.main : zipmap([gremlin_db_id.name], [gremlin_db_id.id])]
  description = "Gremlin API DB IDs"
}

output "gremlin_graph_id" {
  value       = [for gremlin_graph_id in azurerm_cosmosdb_gremlin_graph.main : zipmap([gremlin_graph_id.name], [gremlin_graph_id.id])]
  description = "Gremlin API Graph IDs"
}

# Output Mongo reference 
output "mongo_db_id" {
  value       = [for mongo_db_id in azurerm_cosmosdb_mongo_database.main : zipmap([mongo_db_id.name], [mongo_db_id.id])]
  description = "Mongo API DB IDs"
}

output "mongo_db_collection_id" {
  value       = [for mongo_db_collection_id in azurerm_cosmosdb_mongo_collection.main : zipmap([mongo_db_collection_id.name], [mongo_db_collection_id.id])]
  description = "Mongo API Collection IDs"
}

# Output Table reference 
output "table_id" {
  value       = [for table_id in azurerm_cosmosdb_table.main : zipmap([table_id.name], [table_id.id])]
  description = "Table API Table IDs"
}