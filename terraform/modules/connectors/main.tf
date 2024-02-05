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

resource "harness_platform_connector_github" "git_connector" {
  identifier  = "git"
  name        = "git"
  description = "Organization wide git connector using a github app"
  tags        = ["git_token"]
  org_id      = data.harness_platform_organization.this.identifier

  url                 = "https://git.marriott.com/${data.harness_platform_organization.this.identifier}"
  connection_type     = "Account"
  validation_repo     = var.git_validation_repo
  execute_on_delegate = true
  api_authentication {
    github_app {
      installation_id = "org.githubapp_installation_id"
      application_id  = "org.githubapp_id"
      private_key_ref = "org.git_token"
    }
  }
}

//TODO add custom secrets manager connector

resource "harness_platform_connector_docker" "artifactory_docker" {
  identifier = "artifactory"
  name       = "artifactory"
  url        = "https://artifactory.marriott.com"

  type = "Other"
  credentials {
    username_ref = "org.svc_username"
    password_ref = "org.artifactory_token"
  }
}

resource "harness_platform_connector_artifactory" "artifactory_connector" {
  identifier = "artifactory"
  name       = "artifactory"
  url        = "https://artifactory.marriott.com/artifactory"

  credentials {
    username_ref = "org.svc_username"
    password_ref = "org.artifactory_token"
  }
}