variable "harness_account_id" {
  description = "The Harness Account ID"
  type        = string
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "organization_name" {
  description = "The name of the Harness organization"
  type        = string
}

variable "project_name" {
  description = "The name of the Harness project"
  type        = string
  default     = "unknown"
}

variable "usergroup" {
  description = "The name of the Harness user group"
  type        = string
}
