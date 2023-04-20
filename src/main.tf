module "redis_cluster" {
  source             = "container-labs/redis/scaleway"
  version            = "~> 0.2"
  name               = var.md_metadata.name_prefix
  tags               = var.md_metadata.default_tags
  private_network_id = var.network.data.infrastructure.id
  zone               = var.network.specs.scw.zones[0]
  node_type          = var.node_type
  cluster_mode       = var.cluster_mode
}
