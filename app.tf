data "ns_app_env" "this" {
  stack_id = data.ns_workspace.this.stack_id
  app_id   = data.ns_workspace.this.block_id
  env_id   = data.ns_workspace.this.env_id
}

locals {
  app_version = data.ns_app_env.this.version
}

locals {
  app_metadata = tomap({
    // Inject app metadata into capabilities here (e.g. gcs_bucket_id)
    gcs_bucket_id          = google_storage_bucket.this.id
    gcs_bucket_name        = google_storage_bucket.this.name
    backend_id             = google_compute_backend_bucket.this.id
    artifacts_key_template = local.artifacts_key_template
    deployer_email         = google_service_account.deployer.email
  })
}
