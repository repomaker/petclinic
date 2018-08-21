provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  tenant_id = "${var.azure_tenant_id}"
}

resource "azurerm_container_group" "default" {
  name                = "petclinic"
  location            = "East US"
  resource_group_name = "petclinic"
  ip_address_type     = "public"
  dns_name_label      = "clinic-container"
  os_type             = "windows"

  container {
    name   = "petclinic-container"
    image  = "jreedie/windows_petclinic"
    cpu    ="1"
    memory =  "1.5"
    port   = "8090"

    environment_variables {
      "NODE_ENV" = "testing"
    }
  }
}

output "fqdn" {
  value = "${azurerm_container_group.default.fqdn}"
}

