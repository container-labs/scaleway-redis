locals {
  data_infrastructure = {
    id  = module.redis_cluster.id
    grn = "grn::::redis:"
  }

  data_authentication = {
    username = module.redis_cluster.username
    password = module.redis_cluster.password
    # one host per node when size > 1
    # hostname = scaleway_redis_cluster.main.host
    # port     = scaleway_redis_cluster.main.port
  }

  data_security = {
    iam = {
      "read_write" = {
        permission_set = "RedisReadOnly"
      }
    }
  }

  artifact = {
    data = {
      infrastructure = local.data_infrastructure
      authentication = local.data_authentication
      security       = local.data_security
    }
    specs = {
    }
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "authentication"
  provider_resource_id = module.redis_cluster.id
  name                 = "SCW Redis Cluster"
  artifact             = jsonencode(local.artifact)
}
