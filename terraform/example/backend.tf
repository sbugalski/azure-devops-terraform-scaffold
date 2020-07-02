provider "azurerm" {
  version = "=2.13.0"
  features {}
}

terraform {
  required_version = ">= 0.12"
  backend "azurerm" {
  }
}
