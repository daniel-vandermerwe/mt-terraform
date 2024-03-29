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

  configs = {
    "main" = {
      rendered_yaml = templatefile("templates/${var.service_type}.yaml.tpl", { 
        service_name = var.service_name 
        service_id = local.service_id
        service_type = var.service_type
        manifest_connector_ref = var.manifest_connector_ref
        folder_path = var.folder_path
        manifest_repo_type = var.manifest_repo_type
        manifest_repo_name = var.manifest_repo_name
        manifest_branch = var.manifest_branch
        values_path = var.values_path
        artifact_ref = var.artifact_ref
        artifact_connector_ref = var.artifact_connector_ref
        image_path = var.image_path
        registry_hostname = var.registry_hostname
        artifact_source_type = var.artifact_source_type
        custom_service_variables = var.custom_service_variables
        k8s_config_repo_type = var.k8s_config_repo_type
        k8s_manifest_file_paths = var.k8s_manifest_file_paths
        k8s_config_file_paths = var.k8s_config_file_paths
        })
    }
    # Below is an example if we wanted to test a different configuation

    # "TestingExample" = {
    #   rendered_yaml = templatefile("templates/${var.service_type}.yaml.tpl", { 
    #     service_name = var.service_name 
    #     service_id = local.service_id
    #     some_new_variable = var.new_variable
    #     })
    #}
  }
}

resource "harness_platform_service" "service" {
    identifier  = local.service_id
    name        = var.service_name
    description = "The '${var.service_name}' deployment configuration"
    org_id      = var.organization_id
    project_id  = var.project_id
    yaml = local.configs.main.rendered_yaml
}
