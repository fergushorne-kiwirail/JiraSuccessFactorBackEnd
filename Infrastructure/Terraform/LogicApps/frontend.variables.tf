variable "environment" {
  type        = string
  description = "environment name which will be appended to the resource names i.e. dv,ts,ut,pd"
}

variable "region" {
  type        = string
  description = "Region where we will be deploying our resources to to i.e. Australia East(aue),Australia SouthEast(aus)"
}

variable "subnet_environment" {
  type        = string
  description = "subnet environment name which will be appended to the resource names i.e. dev,test,uat,prod."
}

variable "vnet_environment" {
  type        = string
  description = "vnet environment name which will be appended to the resource names i.e. dv,ut,pd."
}

variable "resource_group_name" {
  type        = string
  default     = "integrationshared-rg"
  description = "Resource group name resources will be deployed to"
}

variable "frontend_resource_group_name" {
  type        = string
  default     = "integrationfrontend-rg"
  description = "Frontend Resource group name resources will be deployed to"
}

variable "backend_resource_group_name" {
  type        = string
  default     = "integrationbackend-rg"
  description = "Backend Resource group name resources will be deployed to"
}

variable "application_insights_name" {
  type        = string
  default     = "integration-appinsight"
  description = "Specify the name for the app insights service which will be used by the function"
}

variable "appservice_plan_logicapp_name" {
  type        = string
  default     = "integration-logic-asp"
  description = "Specify the name for the app service plan"
}

variable "api_management_name" {
  type        = string
  default     = "kiwirail-apimanager-apim"
  description = "Specify the name for the api management service"
}

variable "logicapp_storage_account_name" {
  type        = string
  default     = "massap01logicsa"
  description = "Specify the name for the function app storage account"
}
variable "container_service_storage_account_name" {
  type        = string
  default     = "massap01sa"
  description = "Specify the name for the container service storage account"
}

variable "logic_app_name" {
  type        = string
  default     = "integration-mas-sap-logic"
  description = "Specify the name for the logic app service"
}

variable "subnet_name" {
  type        = string
  default     = "IntGenSubnet02"
  description = "Specify the name of the subnet to integrate logic aapp"
}

variable "vnet_name" {
  type        = string
  default     = "net-vnet"
  description = "Specify the name of the subnet to integrate logic app"
}

variable "dns_server_kiwirail" {
  type        = string
  description = "Specify the Internal DNS server IP address for KiwiRail"
}

variable "dns_server_microsoft" {
  type        = string
  default     = "168.63.129.16"
  description = "Specify the virtual public IP address that is used to facilitate a communication channel to Azure platform resources. Required for DNS resolution"
}

variable "ip_address_list" {
  type        = list
  description = "IP Address List to whitelist on the azure function"
}

variable "keyvault_name" {
  type        = string
  default     = "integration-kv"
  description = "Specify the name for the key vault"
}

variable "sappassword_name" {
  type        = string
  description = "Name of the sappassword secret in key vault"
}

variable "sapusername_name" {
  type        = string
  description = "Name of the sapusername secret in key vault"
}

variable "maximoauth_apikey" {
  type        = string
  description = "Name of the apikey secret in key vault"
}