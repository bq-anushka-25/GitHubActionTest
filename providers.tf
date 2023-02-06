terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.23.0"
    }
  }
}
provider "azurerm" {
  use_oidc = true
  features {}
}