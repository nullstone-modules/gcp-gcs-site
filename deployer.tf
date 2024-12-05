locals {
  truncated_len = min(length(local.block_ref), 28 - length("deployer--12345"))
  deployer_name = "deployer-${substr(local.block_ref, 0, local.truncated_len)}-${random_string.resource_suffix.result}"
}

resource "google_service_account" "deployer" {
  account_id   = local.deployer_name
  display_name = "Deployer for ${local.block_name}"
}

resource "google_service_account_key" "deployer" {
  service_account_id = google_service_account.deployer.account_id
}

resource "google_storage_bucket_iam_member" "deployer" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.deployer.email}"
}

# TODO: Add permissions for managing CDNs created via capabilities
# resource "google_project_iam_member" "cdn" {
#   project = local.project_id
#   role    = "roles/compute.networkAdmin"
#   member  = "serviceAccount:${google_service_account.deployer.email}"
# }
