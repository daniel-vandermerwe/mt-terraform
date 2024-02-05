output "git_connector" {
  value = harness_platform_connector_github.git_connector
}

output "artifactory_connector" {
  value = harness_platform_connector_artifactory.artifactory_connector
}

output "artifactory_docker" {
  value = harness_platform_connector_docker.artifactory_docker
}