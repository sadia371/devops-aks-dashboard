provider "azurerm" {
  features {}
  subscription_id = "50c3d4bd-14b8-40ba-a53e-bc558cbc7dd9"
}

resource "azurerm_resource_group" "rg" {
  name     = "devops-rg"
  location = "eastus"
}

resource "azurerm_container_registry" "acr" {
  name                = "sadiadevopsacr786"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "devops-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "devopsaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  sku_tier = "Free"
}