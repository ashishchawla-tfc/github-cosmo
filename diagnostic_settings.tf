#---------------------------------------------------------------
# azurerm monitoring diagnostics - Azure Cosmosdb
#---------------------------------------------------------------
# Use this data source to fetch all available log and metrics categories
data "azurerm_monitor_diagnostic_categories" "dc" {
  resource_id = azurerm_cosmosdb_account.main.id
}

resource "azurerm_monitor_diagnostic_setting" "ds" {
  count                          = var.enable_diagnostic_settings ? 1 : 0
  name                           = lower(format("diagnostic_settings"))
  target_resource_id             = azurerm_cosmosdb_account.main.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"
  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.dc.log_category_types
    content {
      category = entry.value
    }
  }
  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.dc.metrics
    content {
      category = entry.value
      enabled  = true
    }
  }
  lifecycle {
    ignore_changes = [enabled_log, metric]
  }
}