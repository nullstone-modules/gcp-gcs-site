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
  artifacts_key_template = var.enable_versioned_assets ? "{{app-version}}/" : ""
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
