module "network" {
  for_each = var.networks
  source   = "github.com/lab-gke-se/modules//network//vpc?ref=main"
  project  = local.projects.prj_dev_network.project_id
  name     = each.key
  # description     = "The development shared network"
  shared_vpc_host       = try(each.value.shared_vpc_host, false)
  routing_mode          = try(each.value.routing_mode, null)
  delete_default_routes = try(each.value.delete_default_routes, false)
}

module "subnets" {
  for_each         = var.networks
  source           = "github.com/lab-gke-se/modules//network//subnets?ref=main"
  project          = local.projects.prj_dev_network.project_id
  network          = module.network[each.key].id
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges

  depends_on = [module.network]
}
