# create the AppService Plan 
resource "azurerm_service_plan" "appserviceplan" {
  
  name                      = var.app_service_plan_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.default.name
  os_type                   = "Linux"
  sku_name                  = "B1"
     
}

# Create a Linux Web App 
resource "azurerm_linux_web_app" "appservice" {
name                      = var.web_app_name
location                  = var.location
resource_group_name       = azurerm_resource_group.default.name
https_only                = true
virtual_network_subnet_id = azurerm_subnet.app.id
service_plan_id           = azurerm_service_plan.appserviceplan.id

site_config {
                application_stack {
                    python_version = "3.10"
                }
              vnet_route_all_enabled  = true
              app_command_line = "python -m uvicorn main:app --host 0.0.0.0"
            }

app_settings = {
    conn_str = "postgresql://${var.postgres_admin_name}:${var.postgres_admin_password}@${var.postgres_server_name}.postgres.database.azure.com/${var.postgres_db_name}?sslmode=require"
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
    }

provisioner "local-exec" {
   command = "az webapp deployment source config --branch ${var.branch} --manual-integration --name ${var.web_app_name} --repo-url ${var.repo_url} --resource-group ${var.resource_group}"
 }

depends_on = [ azurerm_service_plan.appserviceplan, azurerm_postgresql_flexible_server_database.default ]       
}

# resource "azurerm_app_service_source_control" "example" {
#   app_id   = azurerm_linux_web_app.appservice.id
#   repo_url = "https://github.com/krassykirov/FastApiTest"
#   branch   = "adding_photo_list_field"  
# }

# resource null_resource "set_startup_cmd" {
#   provisioner "local-exec" {
#     command = "az webapp config set --resource-group ${var.resource_group} --name ${var.web_app_name} --startup-file='python -m uvicorn main:app --host 0.0.0.0'"
# }
#   depends_on  = [ azurerm_linux_web_app.appservice ]  
# }

# App Service Autoscale settings # require app service plan >= Premium v3 P0V3
resource "azurerm_monitor_autoscale_setting" "appserviceplan_autoscale" {
  name                      ="auto-scale"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.default.name
  target_resource_id        = azurerm_service_plan.appserviceplan.id
  enabled                   = true
  profile {
                name = "defaultProfile"

                capacity {
                            default = 1
                            minimum = 1
                            maximum = 3
                        }
        


                # Increase the Instance count by 1 when CPU usage is 85% consitanty for  5 mins
                rule {
                        metric_trigger {
                                            metric_name        = "CpuPercentage"
                                            metric_resource_id = azurerm_service_plan.appserviceplan.id
                                            time_grain         = "PT1M"
                                            statistic          = "Average"
                                            time_window        = "PT5M"
                                            time_aggregation   = "Average"
                                            operator           = "GreaterThan"
                                            threshold          = 85
                                        }

                        scale_action {
                                            direction = "Increase"
                                            type      = "ChangeCount"
                                            value     = "1"
                                            cooldown  = "PT1M"
                                        }
                    }

                # Decrease the Instance count by 1 when CPU usage is 40% or less consitanty for 5 mins
                rule {
                        metric_trigger {
                                            metric_name        = "CpuPercentage"
                                            metric_resource_id = azurerm_service_plan.appserviceplan.id
                                            time_grain         = "PT1M"
                                            statistic          = "Average"
                                            time_window        = "PT5M"
                                            time_aggregation   = "Average"
                                            operator           = "LessThan"
                                            threshold          = 40
                                        }

                        scale_action {
                                            direction = "Decrease"
                                            type      = "ChangeCount"
                                            value     = "1"
                                            cooldown  = "PT1M"
                                        }
                    }


                # Increase the Instance count by 1 when Memory usage is 85% consitanty for 5 mins
                rule {
                        metric_trigger {
                                            metric_name        = "MemoryPercentage"
                                            metric_resource_id = azurerm_service_plan.appserviceplan.id
                                            time_grain         = "PT1M"
                                            statistic          = "Average"
                                            time_window        = "PT5M"
                                            time_aggregation   = "Average"
                                            operator           = "GreaterThan"
                                            threshold          = 85
                                        }

                        scale_action {
                                            direction = "Increase"
                                            type      = "ChangeCount"
                                            value     = "1"
                                            cooldown  = "PT1M"
                                        }
                    }

                # Decrease the Instance count by 1 when Memory usage is 40% or less consitanty for 5 mins
                rule {
                        metric_trigger {
                                            metric_name        = "MemoryPercentage"
                                            metric_resource_id = azurerm_service_plan.appserviceplan.id
                                            time_grain         = "PT1M"
                                            statistic          = "Average"
                                            time_window        = "PT5M"
                                            time_aggregation   = "Average"
                                            operator           = "LessThan"
                                            threshold          = 40
                                        }

                        scale_action {
                                            direction = "Decrease"
                                            type      = "ChangeCount"
                                            value     = "1"
                                            cooldown  = "PT1M"
                                        }
                    }

   }
}