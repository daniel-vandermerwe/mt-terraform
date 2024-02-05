service:
    name: ${service_name}
    identifier: ${service_id}
    serviceDefinition:
        spec:
            manifests:
            - manifest:
                identifier: manifest1
                type: K8sManifest
                spec:
                    store:
                      type: Github
                      spec:
                        connectorRef: <+input>
                        gitFetchType: Branch
                        paths:
                        - files1
                        repoName: <+input>
                        branch: master
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
              - name: var1
                type: String
                value: val1
              - name: var2
                type: String
                value: val2
        type: ${service_type}
        gitOpsEnabled: false

service.serviceDefinition.spec.manifests[0].manifest.spec.store: null found,