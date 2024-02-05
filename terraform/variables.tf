variable "harness_endpoint" {
  description = "The Harness Endpoint"
  type        = string
  default     = "https://app.harness.io/gateway"
}

variable "harness_account_id" {
  description = "The Harness Account ID"
  type        = string
}

variable "harness_api_key" {
  description = "The Harness API Key"
  type        = string
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "entities" {
  description = "Organization and project structure"
  type        = object({
    organization = string
    projects     = set(string)
  })
}

variable "roles" {
  description = "Roles to apply to the organization and projects"
  type        = object({
    organization = list(string)
    project      = list(string)
  })
}

variable "linked_sso_id" {
  description = "The ID of the linked SSO provider"
  type        = string
}

variable "linked_sso_display_name" {
  description = "The display name of the linked SSO provider"
  type        = string
}

variable "git_validation_repo" {
  description = "Repo to use to validate created git connector"
  type        = string
}
