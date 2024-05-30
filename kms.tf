# module "prj_dev_network_kms_key_ring" {
#   source = "github.com/capileus/kms//key_ring?ref=0.1"

#   name     = "prj-dev-network-key-ring"
#   project  = local.projects["prj_dev_network"].project_id
#   location = local.location
# }

# module "prj_dev_network_kms_key" {
#   source = "github.com/capileus/kms//key?ref=0.1"

#   name     = "prj-dev-network-key"
#   project  = local.projects["prj_dev_network"].project_id
#   key_ring = module.prj_dev_network_kms_key_ring.id
#   services = local.prj_dev_network_services
# }

