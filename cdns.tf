locals {
  cdn_url_map_names = [for cdn in try(local.capabilities.cdns, []) : cdn["url_map_name"]]
}
