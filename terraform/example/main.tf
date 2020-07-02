resource "azurerm_resource_group" "example" {
  name     = "${var.env}-${var.prefix}-rg"
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = "${var.env}${var.prefix}sa"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "example" {
  name                 = "${var.env}-${var.prefix}-aci-share"
  storage_account_name = azurerm_storage_account.example.name
  quota                = 10
}

resource "azurerm_container_group" "example" {
  name                = "${var.env}-${var.prefix}-ci"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "public"
  dns_name_label      = "${var.env}-${var.prefix}-ci"
  os_type             = "linux"

  container {
    name     = "webserver"
    image    = "seanmckenna/aci-hellofiles"
    cpu      = "1"
    memory   = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    volume {
      name       = "logs"
      mount_path = "/aci/logs"
      read_only  = false
      share_name = azurerm_storage_share.example.name

      storage_account_name = azurerm_storage_account.example.name
      storage_account_key  = azurerm_storage_account.example.primary_access_key
    }
  }

  tags = {
    environment = "${var.env}"
  }
}