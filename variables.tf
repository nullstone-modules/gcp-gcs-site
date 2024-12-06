variable "env_vars_filename" {
  type    = string
  default = "env.json"

  description = <<EOF
The name of the configuration file that will store environment variables.
This should only be changed if the default 'env.json' collides with existing content.
EOF
}

variable "enable_versioned_assets" {
  type        = bool
  description = "Enable/Disable serving assets from versioned Cloud Storage subdirectories"
  default     = true
}

locals {
  artifacts_key_template = var.enable_versioned_assets ? "/{{app-version}}" : ""
}

variable "cors_origins" {
  type        = list(string)
  default     = ["*"]
  description = "The list of Origins eligible to receive CORS response headers."
}

variable "cors_methods" {
  type        = list(string)
  default     = ["*"]
  description = "The list of HTTP methods on which to include CORS response headers (GET, OPTIONS, POST, etc)."
}

variable "cors_max_age" {
  type        = number
  default     = 31536000
  description = "The number of seconds to return in the Access-Control-Max-Age header"
}

variable "cors_response_headers" {
  type = list(string)
  default = [
    "Access-Control-Expose-Headers",
    "Access-Control-Allow-Origin",
    "Access-Control-Allow-Methods",
  ]
  description = ""
}

variable "default_ttl" {
  type        = number
  default     = 86400
  description = <<EOF
The default TTL for cached content when the origin doesn't specify a TTL.
EOF
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = <<EOF
The maximum amount of time content can be cached, regardless of what the origin specifies.
EOF
}

variable "serve_while_stale" {
  type        = number
  default     = 86400
  description = <<EOF
The number of seconds to serve stale content before expiring.
The default is 86400 seconds (1 day) which means the CDN will serve stale content from the cache for up to 1 day.
After this delay, the CDN will update its cache for the asset.
If the asset no longer exists in the bucket, the CDN will return 502 Bad Gateway.
EOF
}
