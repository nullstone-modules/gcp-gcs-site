resource "google_storage_bucket" "this" {
  name                        = local.resource_name
  location                    = "US"
  storage_class               = "MULTI_REGIONAL"
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = var.cors_origins
    response_header = var.cors_response_headers
    method          = var.cors_methods
    max_age_seconds = var.cors_max_age
  }

  force_destroy = true
}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_compute_backend_bucket" "this" {
  name                 = local.resource_name
  description          = "CDN for GCS Bucket ${local.resource_name}"
  bucket_name          = google_storage_bucket.this.name
  enable_cdn           = true
  compression_mode     = "AUTOMATIC"
  edge_security_policy = google_compute_security_policy.this.id

  cdn_policy {
    cache_mode        = "CACHE_ALL_STATIC"
    default_ttl       = var.default_ttl
    max_ttl           = var.max_ttl
    serve_while_stale = var.serve_while_stale
  }
}

resource "google_compute_security_policy" "this" {
  name        = local.resource_name
  description = "Security policy for ${local.resource_name}"
  type        = "CLOUD_ARMOR_EDGE"
}