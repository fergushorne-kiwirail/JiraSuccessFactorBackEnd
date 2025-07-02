tags = {
    author        = "terraform"
    owner         = "Jerry Hsiung"
    owner_role    = "Integration Manager"
    owner_contact = "Jerry.Hsiung@kiwirail.co.nz"
    project       = "TCS Project"
    application   = "Integration"
    location      = "australiaeast"
    environment   = "dv"
}

region = "aue"

environment = "dv"

subnet_environment = "Dev"

vnet_environment = "dv"

sappassword_name = "dv-aue-mas-sap-sap-password"

sapusername_name = "dv-aue-mas-sap-sap-username"

maximoauth_apikey = "dv-aue-mas-sap-maximoauth-apikey"

dns_server_kiwirail = "172.23.4.10"

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
      },
    {
        ip_address = "124.157.84.190/32"
        name = "Adaptiv IP"
        action = "Allow"
        priority = "300"
    }
]
