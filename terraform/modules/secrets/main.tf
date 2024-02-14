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

resource "harness_platform_secret_text" "git_token" {
  identifier  = "git_token"
  name        = "git_token"
  description = "Organization wide git token for use with github app"
  tags        = ["git_token"]
  org_id      = data.harness_platform_organization.this.identifier

  secret_manager_identifier = "org.git_token_csm"
  value_type                = "CustomSecretManagerValues"
  value                     = ""
}

resource "harness_platform_secret_text" "githubapp_installation_id" {
  identifier  = "githubapp_installation_id"
  name        = "githubapp_installation_id"
  description = "Organization wide github app installation id"
  tags        = ["githubapp_installation_id"]
  org_id      = data.harness_platform_organization.this.identifier

  secret_manager_identifier = "org.harnessSecretManager"
  value_type                = "Inline"
  value                     = "replace-me"
}

resource "harness_platform_secret_text" "githubapp_id" {
  identifier  = "githubapp_id"
  name        = "githubapp_id"
  description = "Organization wide github app  id"
  tags        = ["githubapp_id"]
  org_id      = data.harness_platform_organization.this.identifier

  secret_manager_identifier = "org.harnessSecretManager"
  value_type                = "Inline"
  value                     = "replace-me"
}

resource "harness_platform_secret_text" "svc_username" {
  identifier                = "svc_username"
  name                      = "svc_username"

  description = "Organization wide service account username"
  tags        = ["svc_username"]
  org_id      = data.harness_platform_organization.this.identifier

  secret_manager_identifier = "micrypteastvaultcloudmarriottcom"
  value_type                = "Reference"
  value                     = "/devops_tools/harness/${data.harness_platform_organization.this.identifier}#svc_username"
}

resource "harness_platform_secret_text" "artifactory_token" {
  identifier  = "artifactory_token"
  name        = "artifactory_token"
  description = "Organization wide artifactory token for use with artifactory connector"
  tags        = ["artifactory_token"]
  org_id      = data.harness_platform_organization.this.identifier

  secret_manager_identifier = "micrypteastvaultcloudmarriottcom"
  value_type                = "Reference"
  value                     = "/devops_tools/harness/${data.harness_platform_organization.this.identifier}#artifactory_token"
}
