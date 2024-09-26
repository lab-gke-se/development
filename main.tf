locals {
  environment = {
    domain          = local.organization.domain
    organization_id = local.organization.org_id
  }

  organization     = data.terraform_remote_state.bootstrap.outputs.organization
  folders          = data.terraform_remote_state.bootstrap.outputs.folders
  projects         = data.terraform_remote_state.bootstrap.outputs.projects
  service_accounts = data.terraform_remote_state.bootstrap.outputs.service_accounts
  location         = data.terraform_remote_state.bootstrap.outputs.location

  hpc_1_kms_services = [
    "artifactregistry.googleapis.com",
    "cloudfunctions.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "pubsub.googleapis.com",
    "secretmanager.googleapis.com",
    "storage.googleapis.com"
  ]

  substitutions = {}

  network_files    = fileset("${path.module}/config/network", "*.yaml")
  subnetwork_files = fileset("${path.module}/config/subnetwork", "*.yaml")
  firewall_files   = fileset("${path.module}/config/firewall", "*.yaml")
  dns_files        = fileset("${path.module}/config/dns", "*.yaml")

  network_configs    = { for filename in local.network_files : replace(filename, ".yaml", "") => yamldecode(templatefile("${path.module}/config/network/${filename}", local.substitutions)) }
  subnetwork_configs = { for filename in local.subnetwork_files : replace(filename, ".yaml", "") => yamldecode(templatefile("${path.module}/config/subnetwork/${filename}", local.substitutions)) }
  firewall_configs   = { for filename in local.firewall_files : replace(filename, ".yaml", "") => yamldecode(templatefile("${path.module}/config/firewall/${filename}", local.substitutions)) }
  dns_configs        = { for filename in local.dns_files : replace(filename, ".yaml", "") => yamldecode(templatefile("${path.module}/config/dns/${filename}", local.substitutions)) }
}
