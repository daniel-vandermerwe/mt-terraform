harness_account_id="I--xTRIGQo6eC5dElqSEtQ"
harness_api_key="<+secrets.getValue("harnessapikey")>"
harness_endpoint="https://app.harness.io/gateway"
organization_id="<+pipeline.variables.organizationId>"
project_id="<+pipeline.variables.projectId>"
service_name="<+pipeline.variables.serviceName>"
service_type="<+pipeline.variables.serviceType>"
manifest_connector_ref = "account.Evolutio_Bitbucket"
manifest_repo_type = "Bitbucket"
manifest_repo_name = "kube-cluster-config"
manifest_branch = "master"
k8s_config_repo_type = "Bitbucket"
k8s_manifest_file_paths = [
    "/us-east-1/manifest1.yaml",
    "/us-east-1/manifest2.yaml"
]
k8s_config_file_paths = [
    "/us-east-1/config1.yaml",
    "/us-east-1/config2.yaml"
]