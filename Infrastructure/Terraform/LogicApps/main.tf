################ Retrive data sources ################

data "azurerm_resource_group" "shared" {
  name = "${var.environment}-${var.region}-${var.resource_group_name}"
}

data "azurerm_resource_group" "frontend" {
  name = "${var.environment}-${var.region}-${var.frontend_resource_group_name}"
}

data "azurerm_resource_group" "backend" {
  name = "${var.environment}-${var.region}-${var.backend_resource_group_name}"
}

data "azurerm_key_vault" "keyvault" {
  name                = "${var.environment}-${var.region}-${var.keyvault_name}"
  resource_group_name = data.azurerm_resource_group.shared.name
}

data "azurerm_key_vault_secret" "sappassword" {
  name         = var.sappassword_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_service_plan" "backend" {
  name                = "${var.environment}-${var.region}-${var.appservice_plan_logicapp_name}"
  resource_group_name = data.azurerm_resource_group.backend.name
}

data "azurerm_application_insights" "shared" {
  name                = "${var.environment}-${var.region}-${var.application_insights_name}"
  resource_group_name = data.azurerm_resource_group.shared.name
}

data "azurerm_subnet" "network" {
  name                 = "${var.subnet_environment}${var.subnet_name}"
  virtual_network_name = "${var.vnet_environment}-${var.region}-${var.vnet_name}"
  resource_group_name  = "networking-${var.vnet_environment}-${var.region}-rg"
}

data "azurerm_api_management" "frontend" {
  name                = "${var.environment}-${var.region}-${var.api_management_name}"
  resource_group_name = data.azurerm_resource_group.frontend.name
}

locals {
  ip_address_list_default = [
    {
      ip_address = "${data.azurerm_api_management.frontend.public_ip_addresses[0]}/32"
      name       = "${data.azurerm_api_management.frontend.name}"
      action     = "Allow"
      priority   = "100"
    }
  ]
}


################ Create Logic app resources ################

resource "azurerm_storage_account" "backendmassaplogicapp" {
  name                     = "${var.environment}${var.region}${var.logicapp_storage_account_name}"
  resource_group_name      = data.azurerm_resource_group.backend.name
  location                 = data.azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_account" "backendmassap" {
  name                     = "${var.environment}${var.region}${var.container_service_storage_account_name}"
  resource_group_name      = data.azurerm_resource_group.backend.name
  location                 = data.azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}


resource "azurerm_logic_app_standard" "backendmassap" {
  name                        = "${var.environment}-${var.region}-${var.logic_app_name}"
  location                    = data.azurerm_resource_group.backend.location
  resource_group_name         = data.azurerm_resource_group.backend.name
  app_service_plan_id         = data.azurerm_service_plan.backend.id
  storage_account_name        = azurerm_storage_account.backendmassaplogicapp.name
  storage_account_access_key  = azurerm_storage_account.backendmassaplogicapp.primary_access_key
  https_only                  = true
  virtual_network_subnet_id   = data.azurerm_subnet.network.id
  version                     = "~4"
  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING      = "${data.azurerm_application_insights.shared.connection_string}"
    WEBSITE_DNS_SERVER                         = "${var.dns_server_kiwirail}"
    WEBSITE_DNS_ALT_SERVER                     = "${var.dns_server_microsoft}"
    FUNCTIONS_WORKER_RUNTIME                   = "node"
    WEBSITE_NODE_DEFAULT_VERSION               = "~18"
    SAPPO_Username                             = "@Microsoft.KeyVault(VaultName=${var.environment}-${var.region}-${var.keyvault_name};SecretName=${var.sapusername_name})"
    SAPPO_Password                             = "@Microsoft.KeyVault(VaultName=${var.environment}-${var.region}-${var.keyvault_name};SecretName=${var.sappassword_name})"
    MaximoAuthApiKey                           = "@Microsoft.KeyVault(VaultName=${var.environment}-${var.region}-${var.keyvault_name};SecretName=${var.maximoauth_apikey})"
  }

  site_config {
    always_on         = true
    ftps_state        = "Disabled"
    dotnet_framework_version = "v6.0"
    use_32_bit_worker_process = false
    vnet_route_all_enabled = true
    dynamic "ip_restriction" {
      for_each = concat(var.ip_address_list, local.ip_address_list_default)
      content {
        ip_address                = ip_restriction.value.ip_address
        name                      = ip_restriction.value.name
        priority                  = ip_restriction.value.priority
        action                    = ip_restriction.value.action
        service_tag               = null
        virtual_network_subnet_id = null
        headers                   = null
      }
    }
  }

  tags = var.tags
  identity {
    type = "SystemAssigned"
  }
}

resource "null_resource" "exportlogicappinfo" {

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "echo \"##vso[task.setvariable variable=AZ_RESOURCEGROUPNAME;]${data.azurerm_resource_group.backend.name}\""
  }

  provisioner "local-exec" {
    command =  "echo \"##vso[task.setvariable variable=AZ_LOGICAPPNAME;]${var.environment}-${var.region}-${var.logic_app_name}\""
  }
  depends_on = [ azurerm_logic_app_standard.backendmassap ]
  
}