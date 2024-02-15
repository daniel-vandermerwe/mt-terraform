terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.30.2"
    }
  }
}

data "harness_platform_organization" "this" {
  name = var.organization_name == "" ? "unknown" : var.organization_name
}

resource "harness_platform_variables" "git_connector_identifier" {
  identifier  = "gitConnector"
  name        = "gitConnector"
  description = "Organization wide git connector reference"
  org_id      = data.harness_platform_organization.this.identifier
  type        = "string"

  spec {
    value_type  = "FIXED"
    fixed_value = "org.git"
  }
}

resource "harness_platform_variables" "docker_connector_identifier" {
  identifier  = "dockerConnector"
  name        = "dockerConnector"
  description = "Organization wide docker connector for artifactory"
  org_id      = data.harness_platform_organization.this.identifier
  type        = "string"

  spec {
    value_type  = "FIXED"
    fixed_value = "org.artifactoryDocker"
  }
}
