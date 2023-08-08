output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "postgres_flexible_server" {
  value = azurerm_postgresql_flexible_server.default.name
}

output "postgres_database_name" {
  value = azurerm_postgresql_flexible_server_database.default.name
}

output "postgres_admin_password" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.default.administrator_password
}

output "web_app" {
  value = azurerm_linux_web_app.appservice.default_hostname
}