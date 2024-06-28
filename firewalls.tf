module "firewall" {
  for_each = local.firewall_configs
  source   = "github.com/lab-gke-se/modules//network/firewall/rule?ref=firewall"

  project = local.projects.prj_dev_network.project_id

  network            = each.value.network
  name               = each.value.name
  description        = try(each.value.description, null)
  disabled           = try(each.value.disabled, null)
  priority           = try(each.value.priority, null)
  direction          = try(each.value.direction, null)
  source_ranges      = try(each.value.sourceRanges, null)
  destination_ranges = try(each.value.destinationRanges, null)
  allowed            = try(each.value.allowed, null)
  denied             = try(each.value.denied, null)
  log_config         = try(each.value.logConfig, null)
}
