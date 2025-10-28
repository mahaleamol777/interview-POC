terraform {
  required_version = ">= 1.1.0"

  # Use local backend by default. Optionally configure azurerm backend in backend.tf
}

provider "azurerm" {
  features {}
}

