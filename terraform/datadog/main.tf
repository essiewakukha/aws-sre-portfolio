# PR 11 — Datadog monitors and dashboard as code. Separate state from AWS infra.

terraform {
  required_version = ">= 1.10"
  required_providers {
    datadog = { source = "DataDog/datadog", version = "~> 3.0" }
  }
  backend "s3" {
    bucket       = "<yourname>-sre-portfolio-tfstate" # TODO
    key          = "datadog/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = var.datadog_api_url
}

variable "datadog_api_key" {
  type      = string
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  sensitive = true
}

variable "datadog_api_url" {
  description = "https://api.datadoghq.com/ (US1) or https://api.datadoghq.eu/ (EU)"
  type        = string
  default     = "https://api.datadoghq.com/"
}

variable "notify" {
  description = "Notification handle, e.g. @you@example.com"
  type        = string
}