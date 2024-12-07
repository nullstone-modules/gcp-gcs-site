locals {
  lb_log_filters = [
    for name in local.cdn_url_map_names :
    "(resource.type=\"http_load_balancer\" AND resource.labels.url_map_name=\"${name}\")"
  ]
  bucket_log_filter        = "(resource.type=\"gcs_bucket\" AND resource.labels.bucket_name=\"${google_storage_bucket.this.name}\")"
  log_filters              = concat(local.lb_log_filters, [local.bucket_log_filter])
  log_filter               = join(" OR ", local.log_filters)
  truncated_log_reader_len = min(length(local.block_ref), 28 - length("logs--12345"))
  log_reader_name          = "logs-${substr(local.block_ref, 0, local.truncated_log_reader_len)}-${random_string.resource_suffix.result}"
}

resource "google_service_account" "log_reader" {
  account_id   = local.log_reader_name
  display_name = "${local.block_name} Log Reader"
}

resource "google_project_iam_member" "log_reader" {
  project = local.project_id
  role    = "roles/logging.viewer"
  member  = "serviceAccount:${google_service_account.log_reader.email}"
}
