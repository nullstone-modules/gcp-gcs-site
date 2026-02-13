locals {
  truncated_len = min(length(local.block_ref), 28 - length("deployer--12345"))
  deployer_name = "deployer-${substr(local.block_ref, 0, local.truncated_len)}-${random_string.resource_suffix.result}"
}

resource "google_service_account" "deployer" {
  account_id   = local.deployer_name
  display_name = "Deployer for ${local.block_name}"
}

// Allow Nullstone Agent to impersonate the deployer account
resource "google_service_account_iam_binding" "deployer_nullstone_agent" {
  service_account_id = google_service_account.deployer.id
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = ["serviceAccount:${local.ns_agent_service_account_email}"]
}

resource "google_storage_bucket_iam_member" "deployer_bucket_admin" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.deployer.email}"
}

resource "google_storage_bucket_iam_member" "deployer_bucket_folder_admin" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.folderAdmin"
  member = "serviceAccount:${google_service_account.deployer.email}"
}

resource "google_project_iam_custom_role" "cdn" {
  role_id     = replace("${local.resource_name}-cdn", "-", "_")
  title       = "${local.block_name} CDN"
  description = "Limited permissions to manage CDNs"
  stage       = "GA"

  permissions = [
    "compute.urlMaps.get",
    "compute.urlMaps.invalidateCache",
    "compute.urlMaps.list",
    "compute.urlMaps.listEffectiveTags",
    "compute.urlMaps.listTagBindings",
    "compute.urlMaps.update",
    "compute.backendBuckets.use",
  ]
}

resource "google_project_iam_member" "cdn" {
  project = local.project_id
  role    = google_project_iam_custom_role.cdn.id
  member  = "serviceAccount:${google_service_account.deployer.email}"
}
