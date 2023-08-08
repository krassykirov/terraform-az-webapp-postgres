# terraform-az-webapp-postgres
Terraform code that implements the architecture described in the following article:
https://learn.microsoft.com/en-us/azure/architecture/solution-ideas/articles/scalable-web-and-mobile-applications-using-azure-database-for-postgresql

1. Create an Azure resource group using azurerm_resource_group
2. Create an Azure virtual network (VNet) using azurerm_virtual_network
3. Create an Azure Network Security Group (NSG) using azurerm_network_security_group
4. Create two Azure subnets via azurerm_subnet for Postgres server and the AppService
5. Create an Azure subnet Network Security Group (NSG) using azurerm_subnet_network_security_group_association
6. Define a private DNS zone within an Azure DNS using azurerm_private_dns_zone
7. Define a private DNS zone VNet link using using azurerm_private_dns_zone_virtual_network_link
8. Deploy an Azure PostgreSQL Flexible Server using azurerm_postgresql_flexible_server
9. Create an Azure PostgreSQL database using azurerm_postgresql_flexible_server_database
10. Deploy Azure App Service Plan using azurerm_service_plan
11. Deploy simple Azure Linux Web App with vNet Integration enabled using azurerm_linux_web_app - https://github.com/krassykirov/FastApiTest
12. Deploy Autoscale settings for app service plan using azurerm_monitor_autoscale_setting

## Installation

Clone the repo:

```git clone https://github.com/krassykirov/terraform-az-webapp-postgres.git```

## Deployment 

In the root folder of your cloned repo run:
   
1. ```terraform init```
2. ```terraform plan -out main.tfplan```
3. ```terraform apply main.tfplan```

## Verify the results
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.
```
Outputs:
postgres_admin_password = <sensitive>
postgres_database_name = "db"
postgres_flexible_server = "krassy"
resource_group_name = "kr-rg-postgres-app"
web_app = "kr-web-postgres.azurewebsites.net"
```
![image](https://github.com/krassykirov/terraform-az-webapp-postgres/assets/12232066/9f64f6c7-9052-44fd-a7b0-c1c8c3ba2811)

