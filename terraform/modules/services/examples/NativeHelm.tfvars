harness_account_id="I--xTRIGQo6eC5dElqSEtQ"
harness_api_key="<+secrets.getValue("harnessapikey")>"
harness_endpoint="https://app.harness.io/gateway"
organization_id="<+pipeline.variables.organizationId>"
project_id="<+pipeline.variables.projectId>"
service_name="<+pipeline.variables.serviceName>"
service_type="<+pipeline.variables.serviceType>"
manifest_connector_ref = "account.Evolutio_Bitbucket"
folder_path = "/charts/apps/analytics-relay-worker"
manifest_repo_type = "Bitbucket"
manifest_repo_name = "kube-cluster-config"
manifest_branch = "master"
values_path = "charts/apps/analytics-relay-worker/values-<+env.name>.yaml"
artifact_ref = "<+input>" # Assuming <+input> is a placeholder for actual input
artifact_connector_ref = "AMP_GCP"
image_path = "evolutio-internal/amp/analytics-relay-worker"
registry_hostname = "us.gcr.io"
artifact_source_type = "Gcr"
custom_service_variables = {
  "var1" = {
    name  = "hotel",
    type  = "String",
    value = "marriott"
  },
  "var2" = {
    name  = "state",
    type  = "String",
    value = "florida"
  }
}