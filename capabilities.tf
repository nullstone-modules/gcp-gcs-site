// This file is replaced by code-generation using 'capabilities.tf.tmpl'
// This file helps app module creators define a contract for what types of capability outputs are supported.
locals {
  capabilities = {
    env = [
      {
        name  = ""
        value = ""
      }
    ]

    cdns = [
      {
        proxy_id     = ""
        url_map_name = ""
      }
    ]

    // private_urls follows a wonky syntax so that we can send all capability outputs into the merge module
    // Terraform requires that all members be of type list(map(any))
    // They will be flattened into list(string) when we output from this module
    private_urls = [
      {
        url = ""
      }
    ]

    // public_urls follows a wonky syntax so that we can send all capability outputs into the merge module
    // Terraform requires that all members be of type list(map(any))
    // They will be flattened into list(string) when we output from this module
    public_urls = [
      {
        url = ""
      }
    ]
  }

  // cap_prefixes is a map indexed by capability name which points to the env_prefix of each capability
  cap_prefixes = tomap({
    x = ""
  })

  cap_env = [
    {
      capability = "x"
      name       = "EXAMPLE_ENV"
      value      = ""
    }
  ]

  cap_secrets = {}
}
