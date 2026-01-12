variable "environment" {
  type        = string
  description = "environment name which will be appended to the resource names i.e. dv,ts,ut,pd"
}

variable "resource_group_name" {
  type        = string
  default     = "integrationshared-rg"
  description = "Resource group name resources will be deployed to"
}

variable "region" {
  type        = string
  description = "Region where we will be deploying our resources to to i.e. Australia East(aue),Australia SouthEast(aus)"
}

variable "key_vault_name" {
  type        = string
  default     = "integration-kv"
  description = "Specify the name for the key vault service"
}

variable "keyvault_mas_sap_sap_password" {-
  type        = string
  description = "MAS SAP Password"
}

variable "keyvault_mas_sap_sap_username" {-
  type        = string
  description = "MAS SAP Username"
}

variable "keyvault_jira_sf_apikey" {
  type        = string
  description = "Jira SF Apikey"
}

variable "logicapp_container_service_name" {
  type        = string
  default     = "mas-sap"
  description = "Name of the container service to use for secret naming"
}
