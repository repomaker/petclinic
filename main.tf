provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id = "${var.auzre_client_id}"
  client_secret = "${var.azure_client_secret}"
  tenant_id = "${var.azure_tenant_id}"
}

resource "azurerm_container_group" "aci-helloworld" {
  name                = "petclinic"
  location            = "East US"
  resource_group_name = "petclinic"
  ip_address_type     = "public"
  dns_name_label      = "clinic-container"
  os_type             = "windows"

  container {
    name   = "petclinic_windows"
    image  = "jreedie/windows_petclinic"
    cpu    ="1"
    memory =  "1.5"
    port   = "8090"

    environment_variables {
      "NODE_ENV" = "testing"
    }
  }
}


