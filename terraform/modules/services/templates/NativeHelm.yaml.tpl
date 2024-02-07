service:
  name: ${service_name}
  identifier: ${service_id}
  serviceDefinition:
    spec:
      manifests:
        - manifest:
            identifier: ${service_name}_manifest
            type: HelmChart
            spec:
              store:
                type: ${manifest_repo_type}
                spec:
                  connectorRef: ${manifest_connector_ref}
                  gitFetchType: Branch
                  folderPath: ${folder_path}
                  repoName: ${manifest_repo_name}
                  branch: ${manifest_branch}
              subChartPath: ""
              valuesPaths:
                - ${values_path}
              skipResourceVersioning: false
              enableDeclarativeRollback: false
              helmVersion: V3
              fetchHelmChartMetadata: false
      artifacts:
        primary:
          primaryArtifactRef: ${artifact_ref}
          sources:
            - spec:
                connectorRef: ${artifact_connector_ref}
                imagePath: ${image_path}
                tag: <+input>
                digest: ""
                registryHostname: ${registry_hostname}
              identifier: ${service_name}_artifact
              type: ${artifact_source_type}
      variables:
        %{ for var in custom_service_variables ~}
        - name: ${var.name}
          type: ${var.type}
          value: ${var.value}
        %{ endfor ~}
    type: ${service_type}