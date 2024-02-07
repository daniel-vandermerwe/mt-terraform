service:
  name: ${service_name}
  identifier: ${service_id}
  tags: {}
  serviceDefinition:
    spec:
      artifacts:
        primary:
          primaryArtifactRef: <+input>
          sources:
            - spec:
                connectorRef: account.AWS_Automation_Acct
                bucketName: harness-qb-artifacts
                region: us-east-1
                filePath: function.zip
              identifier: qbartifact
              type: AmazonS3
      manifests:
        - manifest:
            identifier: LambdaFunctionDefinition
            type: AwsLambdaFunctionDefinition
            spec:
              store:
                type: Bitbucket
                spec:
                  connectorRef: account.Evolutio_Bitbucket
                  gitFetchType: Branch
                  paths:
                    - harness/AWS-Lambda-Function-Definition.yaml
                  repoName: quote-builder
                  branch: main
      variables:
%{ for var in custom_service_variables ~}
        - name: ${var.name}
          type: ${var.type}
          value: ${var.value}
%{ endfor ~}
    type: ${service_type}
  description: Native lambda method