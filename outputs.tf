output "artifacts_bucket_name" {
  value       = google_storage_bucket.this.name
  description = "string ||| The name of the created S3 bucket."
}

output "artifacts_key_template" {
  value       = local.artifacts_key_template
  description = "string ||| Template for s3 directory where files are placed."
}

output "deployer" {
  value = {
    email       = try(google_service_account.deployer.email, "")
    private_key = try(google_service_account_key.deployer.private_key, "")
  }

  description = "object({ email: string, private_key: string }) ||| A GCP service account with explicit privilege to deploy this GCS static site."
  sensitive   = true
}

output "env_vars_filename" {
  value       = var.env_vars_filename
  description = "string ||| The name of the S3 Object that contains a json-encoded configuration file with environment variables."
}

output "private_urls" {
  value       = local.private_urls
  description = "list(string) ||| A list of URLs only accessible inside the network"
}

output "public_urls" {
  value       = local.public_urls
  description = "list(string) ||| A list of URLs accessible to the public"
}

// TODO: Emit url maps for when enable_versioned_assets so the CLI can rewrite path
