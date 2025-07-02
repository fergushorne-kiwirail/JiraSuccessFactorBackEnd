data "azurerm_resource_group" "shared" {
  name     = "${var.environment}-${var.region}-${var.resource_group_name}"
}

data "azurerm_key_vault" "shared" {
  name                = "${var.environment}-${var.region}-${var.key_vault_name}"
  resource_group_name = "${data.azurerm_resource_group.shared.name}"
}

resource "azurerm_key_vault_secret" "mas-sap-sap-password" {
  name         = "${var.environment}-${var.region}-${var.logicapp_container_service_name}-sap-password"
  value        = "${var.keyvault_mas_sap_sap_password}"
  content_type = "plain/text"
  key_vault_id = "${data.azurerm_key_vault.shared.id}"
}

resource "azurerm_key_vault_secret" "mas-sap-sap-username" {
  name         = "${var.environment}-${var.region}-${var.logicapp_container_service_name}-sap-username"
  value        = "${var.keyvault_mas_sap_sap_username}"
  content_type = "plain/text"
  key_vault_id = "${data.azurerm_key_vault.shared.id}"
}

resource "azurerm_key_vault_secret" "mas-sap-maximoauth-apikey" {
  name         = "${var.environment}-${var.region}-${var.logicapp_container_service_name}-maximoauth-apikey"
  value        = "${var.keyvault_mas_sap_maximoauth_apikey}"
  content_type = "plain/text"
  key_vault_id = "${data.azurerm_key_vault.shared.id}"
}