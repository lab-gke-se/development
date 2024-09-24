module "network" {
  for_each = local.network_configs
  # source   = "github.com/lab-gke-se/modules//network/vpc?ref=main"
  source = "github.com/lab-gke-se/modules//network/vpc"

  project               = local.projects.prj_dev_network.project_id
  shared_vpc_host       = false
  delete_default_routes = true

  name                                  = each.value.name
  description                           = try(each.value.description, null)
  routingConfig                         = try(each.value.routingConfig, null)
  autoCreateSubnetworks                 = try(each.value.autoCreateSubnetworks, null)
  mtu                                   = try(each.value.mtu, null)
  enableUlaInternalIpv6                 = try(each.value.enableUlaInternalIpv6, null)
  internalIpv6Range                     = try(each.value.internalIpv6Range, null)
  networkFirewallPolicyEnforcementOrder = try(each.value.networkFirewallPolicyEnforcementOrder, null)
}

module "subnetwork" {
  for_each = local.subnetwork_configs
  source   = "github.com/lab-gke-se/modules//network/subnetwork"

  project                 = local.projects.prj_dev_network.project_id
  network                 = each.value.network
  name                    = each.value.name
  ipCidrRange             = try(each.value.ipCidrRange, null)
  region                  = try(each.value.region, null)
  privateIpGoogleAccess   = try(each.value.privateIpGoogleAccess, null)
  privateIpv6GoogleAccess = try(each.value.privateIpv6GoogleAccess, null)
  purpose                 = try(each.value.purpose, null)
  role                    = try(each.value.role, null)
  stackType               = try(each.value.stackType, null)
  ipv6AccessType          = try(each.value.ipv6AccessType, null)
  externalIpv6Prefix      = try(each.value.externalIpv6Prefix, null)
  secondaryIpRanges       = try(each.value.secondaryIpRanges, null)
  logConfig               = try(each.value.logConfig, null)
}

moved {
  from = module.subnets["onpremise"].google_compute_subnetwork.subnetwork["pupi"]
  to   = module.subnetwork["pupi"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["onpremise"].google_compute_subnetwork.subnetwork["vdi"]
  to   = module.subnetwork["vdi"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["proxy"]
  to   = module.subnetwork["proxy"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["dev-tenant-1"]
  to   = module.subnetwork["dev-tenant-1"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["tenant-gke-1"]
  to   = module.subnetwork["tenant-gke-1"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["tenant-gke-private"]
  to   = module.subnetwork["tenant-gke-private"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["tenant-gke-standard"]
  to   = module.subnetwork["tenant-gke-standard"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["tenant-gke-standard-0"]
  to   = module.subnetwork["tenant-gke-standard-0"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["tenant-gke-standard-1"]
  to   = module.subnetwork["tenant-gke-standard-1"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["tenant-gke-us-central1"]
  to   = module.subnetwork["tenant-gke-us-central1"].google_compute_subnetwork.subnetwork
}

moved {
  from = module.subnets["dev-network"].google_compute_subnetwork.subnetwork["tenant-gke"]
  to   = module.subnetwork["tenant-gke"].google_compute_subnetwork.subnetwork
}
