variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "organization_name" {
  description = "The name of the Harness organization"
  type        = string
}

variable "git_validation_repo" {
  description = "Repo to use for git connector validation"
  type        = string
}
