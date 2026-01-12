tags = {
    author        = "terraform"
    owner         = "Integration Team"
    owner_role    = "Integration Team"
    owner_contact = "ICT.Integration@kiwirail.co.nz"
    project       = "Property CRM"
    application   = "Integration"
    location      = "global"
    environment   = "dv"
}

region = "aue"

environment = "ut"

subnet_environment = "Uat"

vnet_environment = "pd"

sappassword_name = "ut-aue-mas-sap-sap-password"

sapusername_name = "ut-aue-mas-sap-sap-username"

maximoauth_apikey = "ut-aue-mas-sap-maximoauth-apikey"

dns_server_kiwirail = "172.23.3.10,172.24.3.10,10.160.24.11,10.161.1.70"

ip_address_list = [
      {
        ip_address = "188.125.180.0/29"
        name = "KiwiRail Outbound DEV 1"
        action = "Allow"
        priority = "200"
      },
      {
        ip_address = "188.125.180.8/29"
        name = "KiwiRail Outbound DEV 2"
        action = "Allow"
        priority = "200"
      },
      {
        ip_address = "202.37.17.0/25"
        name = "KiwiRail Outbound DEV 3"
        action = "Allow"
        priority = "200"
      },
      {
        ip_address = "202.37.17.128/25"
        name = "KiwiRail Outbound DEV 4"
        action = "Allow"
        priority = "200"
      }
]