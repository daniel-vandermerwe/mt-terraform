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
%{ for var in var.k8s_manifest_file_paths ~}
                        - ${var}
%{ endfor ~}
                        repoName: ${manifest_repo_name}
                        branch: ${manifest_branch}
                    skipResourceVersioning: false
            configFiles:
            - configFile:
                identifier: ${service_name}_configfile
                spec:
                    store:
                      type: ${k8s_config_repo_type}
                      spec:
                        files:
%{ for var in var.k8s_config_file_paths ~}
                          - ${var}
%{ endfor ~}
            variables:
%{ for var in var.custom_service_variables ~}
              - name: ${var.name}
                type: ${var.type}
                value: ${var.value}
%{ endfor ~}
              type: ${service_type}
    gitOpsEnabled: false