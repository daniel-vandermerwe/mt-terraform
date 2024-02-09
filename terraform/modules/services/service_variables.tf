variable "manifest_connector_ref" {
  type    = string
  default = ""
}

variable "folder_path" {
  type    = string
  default = ""
}

variable "manifest_repo_name" {
  type    = string
  default = ""
}

variable "manifest_repo_type" {
  type    = string
  default = ""
}

variable "manifest_branch" {
  type    = string
  default = ""
}

variable "values_path" {
  type    = string
  default = ""
}

variable "artifact_ref" {
  type    = string
  default = ""
}

variable "artifact_connector_ref" {
  type    = string
  default = ""
}

variable "image_path" {
  type    = string
  default = ""
}

variable "registry_hostname" {
  type    = string
  default = ""
}

variable "artifact_source_type" {
  type    = string
  default = ""
}

variable "custom_service_variables" {
  type = map(object({
    name  = string
    type  = string
    value = string
  }))
  default = {}
}

variable "k8s_manifest_file_paths" {
  type    = list(string)
  default = []
}

variable "k8s_config_file_paths" {
  type    = list(string)
  default = []
}

variable "k8s_config_repo_type" {
  type    = string
  default = ""
}