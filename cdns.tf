locals {
  cdn_url_map_ids = [for cdn in try(local.capabilities.cdns, []) : cdn["url_map_id"]]
}
