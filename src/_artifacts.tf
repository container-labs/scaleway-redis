locals {
  data_infrastructure = {
    id  = scaleway_redis_cluster.main.id
    grn = "grn::::redis:"
  }

  data_authentication = {
    username = scaleway_redis_cluster.main.user_name
    password = scaleway_redis_cluster.main.password
    # one host per node when size > 1
    # hostname = scaleway_redis_cluster.main.host
    # port     = scaleway_redis_cluster.main.port
  }

  data_security = {
    iam = {
      "read/write" = {
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
  provider_resource_id = scaleway_redis_cluster.main.id
  name                 = "SCW Redis Cluster"
  artifact             = jsonencode(local.artifact)
}
