service:
  name: analytics-relay-worker
  identifier: analyticsrelayworker
  orgIdentifier: default
  projectIdentifier: AMP
  serviceDefinition:
    spec:
      manifests:
        - manifest:
            identifier: workermanifest
            type: HelmChart
            spec:
              store:
                type: Bitbucket
                spec:
                  connectorRef: account.Evolutio_Bitbucket
                  gitFetchType: Branch
                  folderPath: /charts/apps/analytics-relay-worker
                  repoName: kube-cluster-config
                  branch: master
              subChartPath: ""
              valuesPaths:
                - charts/apps/analytics-relay-worker/values-<+env.name>.yaml
              skipResourceVersioning: false
              enableDeclarativeRollback: false
              helmVersion: V3
              fetchHelmChartMetadata: false
      artifacts:
        primary:
          primaryArtifactRef: <+input>
          sources:
            - spec:
                connectorRef: AMP_GCP
                imagePath: evolutio-internal/amp/analytics-relay-worker
                tag: <+input>
                digest: ""
                registryHostname: us.gcr.io
              identifier: analyticsrelayworkerartifact
              type: Gcr
    type: NativeHelm
