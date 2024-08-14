# Azurerm Provider configuration
provider "azurerm" {
  features {
  }
  alias           = "Shared_Services"
  tenant_id       = "638fcbaf-ba4c-43e1-adae-5475c970fe10"
  subscription_id = "a58bcf82-52dc-4fc8-89bb-eb4f7edbf17e"
}

provider "azurerm" {
  features {
  }
  subscription_id = "0fc7c31e-92f7-4e21-a24d-c003a52a926f"
  tenant_id       = "638fcbaf-ba4c-43e1-adae-5475c970fe10"
}