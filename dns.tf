module "dns" {
  for_each = local.dns_configs
  source   = "github.com/lab-gke-se/modules//network/dns/managed_zone?ref=dns"

  project                   = local.projects.prj_dev_network.project_id
  name                      = each.value.name
  dns_name                  = each.value.dnsName
  description               = try(each.value.description, null)
  labels                    = try(each.value.labels, null)
  visibility                = try(each.value.visibility, null)
  private_visibility_config = try(each.value.privateVisibilityConfig, null)
}
