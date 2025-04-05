terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  subscription_id = "8cd818a3-1004-4d7d-b2d2-4e45880cd697"
  tenant_id       = "2e71ef43-0795-4b46-889b-4d6ca854b64d"
  features {

  }
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "rg" {
  name     = "reactapp-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "reactapp-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "reactapp" {
  name                = "my-react-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  site_config {
    always_on = true
  }

  app_settings = {
    WEBSITE_NODE_DEFAULT_VERSION = "16.13"
  }
}
