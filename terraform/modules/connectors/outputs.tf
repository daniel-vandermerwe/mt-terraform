output "git_connector" {
  value = harness_platform_connector_github.git_connector
}

output "artifactory_helm" {
  value = harness_platform_connector_helm.artifactory_helm
}

output "artifactory_docker" {
  value = harness_platform_connector_docker.artifactory_docker
}

output "vault_connector" {
  value = harness_platform_connector_vault.mi_crypt_east
}