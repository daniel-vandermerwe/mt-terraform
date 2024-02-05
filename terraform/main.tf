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

module "organization" {
  source = "./modules/organization"

  default_tags      = var.default_tags
  organization_name = var.entities.organization
}

module "project" {
  source = "./modules/project"

  for_each = var.entities.projects

  default_tags      = var.default_tags
  organization_name = var.entities.organization
  project           = each.value

  depends_on = [module.organization]
}

locals {
  resource_group_map = concat(
    [
      for entity in [var.entities.organization] : {
        key          = "account"
        organization = entity
        project_name = ""
        role         = "account"
      }
    ],
    [
      for entity in [var.entities.organization] : {
        key          = "${entity}"
        organization = entity
        project_name = ""
        role         = "admin"
      }
    ],
    [
      for pair in setproduct([var.entities.organization], var.entities.projects, var.roles.project) : {
        key          = "${pair[0]}_${pair[1]}_${pair[2]}"
        organization = pair[0]
        project_name = pair[1]
        role         = pair[2]
      }
    ],
  )

  project_role_map = concat(
    [
      for pair in setproduct([var.entities.organization], var.roles.organization) : {
        key          = "${pair[0]}_${pair[1]}"
        organization = pair[0]
        project_name = ""
        role         = pair[1]
      }
    ],
    [
      for pair in setproduct([var.entities.organization], var.entities.projects, var.roles.project) : {
        key          = "${pair[0]}_${pair[1]}_${pair[2]}"
        organization = pair[0]
        project_name = pair[1]
        role         = pair[2]
      }
    ],
  )
}

module "resource_group" {
  source = "./modules/resource_group"

  for_each = {
    for role_map in local.resource_group_map : "${role_map.key}" => role_map
  }

  harness_account_id = var.harness_account_id
  default_tags       = var.default_tags
  organization_name  = each.value.organization
  project_name       = each.value.project_name
  usergroup          = each.value.role

  depends_on = [module.organization, module.project]
}

module "usergroup" {
  source = "./modules/usergroup"

  for_each = {
    for role_map in local.project_role_map : "${role_map.key}" => role_map
  }

  default_tags      = var.default_tags
  organization_name = each.value.organization
  project_name      = each.value.project_name
  usergroup         = each.value.role

  linked_sso_id           = var.linked_sso_id
  linked_sso_display_name = var.linked_sso_display_name

  depends_on = [module.organization, module.project, module.resource_group]
}

module "usergroup_rolebindings" {
  source = "./modules/usergroup_rolebindings"

  for_each = {
    for role_map in local.project_role_map : "${role_map.key}" => role_map
  }

  default_tags      = var.default_tags
  organization_name = each.value.organization
  project_name      = each.value.project_name
  usergroup         = each.value.role
  role              = each.value.role

  depends_on = [module.organization, module.project, module.resource_group, module.usergroup]
}

module "variables" {
  source = "./modules/variables"

  organization_name = var.entities.organization
}

module "secrets" {
  source = "./modules/secrets"

  organization_name = var.entities.organization
}

module "secrets" {
  source = "./modules/connectors"

  organization_name = var.entities.organization
  git_validation_repo = var.git_validation_repo
}