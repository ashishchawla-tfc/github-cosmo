# Customer managed key dependencies  
data "azurerm_key_vault" "main" {
  count               = var.key_vault_name != null ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

data "azurerm_key_vault_key" "main" {
  count        = var.key_vault_key_name != null ? 1 : 0
  name         = var.key_vault_key_name
  key_vault_id = data.azurerm_key_vault.main[count.index].id
}