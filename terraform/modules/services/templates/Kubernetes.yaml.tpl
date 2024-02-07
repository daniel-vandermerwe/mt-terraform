service:
    name: ${service_name}
    identifier: ${service_id}
    serviceDefinition:
        spec:
            manifests:
            - manifest:
                identifier: ${service_name}_manifest
                type: K8sManifest
                spec:
                    store:
                      type: ${manifest_repo_type}
                      spec:
                        connectorRef: ${manifest_connector_ref}
                        gitFetchType: Branch
                        paths:
                        - files1
                        repoName: ${manifest_repo_name}
                        branch: ${manifest_branch}
                    skipResourceVersioning: false
            configFiles:
            - configFile:
                identifier: configFile1
                spec:
                    store:
                      type: Harness
                      spec:
                        files:
                          - <+org.description>
            variables:
%{ for var in var.custom_service_variables ~}
              - name: ${var.name}
                type: ${var.type}
                value: ${var.value}
%{ endfor ~}
              type: ${service_type}
    gitOpsEnabled: false