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
