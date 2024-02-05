service:
  name: quotebuilder
  identifier: quotebuilder_new_harness
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
        - name: functionName
          type: String
          description: ""
          value: <+service.name>
        - name: roleARN
          type: String
          description: ""
          value: arn:aws:iam::831200582800:role/dev-quotebuilder-fn-role
    type: AwsLambda
  description: Native lambda method