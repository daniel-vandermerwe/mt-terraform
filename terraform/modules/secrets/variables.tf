variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "organization_name" {
  description = "The name of the Harness organization"
  type        = string
}
