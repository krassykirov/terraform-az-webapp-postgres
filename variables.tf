variable "resource_group" {
  description = "Resource group name."
  default = "kr-rg-postgres-app"
}

variable "name_prefix" {
  description = "Prefix of the resource name."
  default = "kr"
}

variable "location" {
  description = "Location of the resource."
  default = "eastus"
}

variable "postgres_server_name" {
  description = "Postgres Server Name"
  default = "krassy"
}

variable "postgres_db_name" {
  description = "Postgres Database Name"
  default = "db"
}

variable "postgres_admin_name" {
   description = "Postgres server admin name"
   default = "krassy"
}

variable "postgres_admin_password" {
   description = "Postgres server admin password"
   sensitive   = true
}

variable "web_app_name" {
   description = "Web App Name"
   default = "kr-web-postgres"
}

variable "app_service_plan_name" {
  description = "Web App Service Plan Name"
  default = "kr-appservice-plan"
}

variable "repo_url" {
  description = "Web App Repo Url"
  default = "https://github.com/krassykirov/FastApiTest"
}

variable "branch" {
  description = "Web App repo_url branch"
  default = "adding_photo_list_field"
}