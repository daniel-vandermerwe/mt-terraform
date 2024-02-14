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

  credentials {
    http {
      username  = "username"
      token_ref = "org.git_token"
    }
  }

  api_authentication {
    github_app {
      installation_id = "org.githubapp_installation_id"
      application_id  = "org.githubapp_id"
      private_key_ref = "org.git_token"
    }
  }
}

resource "harness_platform_connector_helm" "artifactory_helm" {
  identifier = "artifactory_helm"
  name       = "Artifactory Helm"
  url        = "https://artifactory.marriott.com/artifactory/helm"
  org_id     = data.harness_platform_organization.this.identifier

  type = "HttpHelmRepo"
  credentials {
    username_ref = "org.svc_username"
    password_ref = "org.artifactory_token"
  }
}

resource "harness_platform_connector_docker" "artifactory_docker" {
  identifier = "artifactory"
  name       = "Artifactory"
  url        = "https://artifactory.marriott.com"
  org_id     = data.harness_platform_organization.this.identifier

  type = "DockerRegistry"
  credentials {
    username_ref = "org.svc_username"
    password_ref = "org.artifactory_token"
  }
}

resource "harness_platform_connector_vault" "mi_crypt_east" {
  identifier = "micrypteastvaultcloudmarriottcom"
  name       = "mi-crypt-east"
  org_id     = data.harness_platform_organization.this.identifier
  url        = "https://mi-crypt-east.vault.cloud.marriott.com"
  vault_url                = "https://mi-crypt-east.vault.cloud.marriott.com"

  base_path = "${data.harness_platform_organization.this.identifier}/kv/"
  secret_engine_name = "${data.harness_platform_organization.this.identifier}/kv"
  app_role_id = "60220029-c378-c9ae-d315-3e116d917eaa"
  secret_id = "account.vaultsecretid"
  secret_engine_version = 2
  namespace = "mi-${data.harness_platform_organization.this.identifier}"
  use_vault_agent = false
  use_aws_iam = false
  use_k8s_auth = false
  renew_app_role_token = false
  read_only = true
  default = true
  access_type = "APP_ROLE"
  renewal_interval_minutes = 10

}