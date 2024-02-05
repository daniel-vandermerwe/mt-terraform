terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.30.2"
    }
  }
}

#Configure the Harness provider for Next Gen resources
provider "harness" {
  endpoint         = var.harness_endpoint
  account_id       = var.harness_account_id
  platform_api_key = var.harness_api_key
}

locals {
    service_id = join("_", [for word in split("--", replace(var.service_name, "/[^\\w]/", "--")) : word])
    rendered_yaml = templatefile("templates/${var.service_type}.yaml.tpl", { 
        service_name = var.service_name 
        service_id = local.service_id
        service_type = var.service_type
        })
    decoded_yaml = yamldecode(local.rendered_yaml)
}

resource "harness_platform_service" "service" {
    identifier  = local.service_id
    name        = var.service_name
    description = "The '${var.service_name}' deployment configuration"
    org_id      = var.organization_id
    project_id  = var.project_id
    yaml = local.rendered_yaml
}
