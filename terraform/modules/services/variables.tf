variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "organization_id" {
  description = "The id of the Harness organization"
  type        = string
}

variable "project_id" {
  description = "The id of the Harness project"
  type        = string
}

variable "service_name" {
  description = "The name of the deployment service"
  type        = string
}

variable "service_type" {
  description = "The type of service that we are setting up"
  type        = string
}

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