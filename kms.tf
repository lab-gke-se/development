module "hpc_1_kms_key_ring" {
  source = "github.com/lab-gke-se/modules//kms/key_ring?ref=main"

  name     = "hpc-1-key-ring"
  project  = local.projects["prj_dev_tenant_1"].project_id
  location = "us-east4"
}

module "hpc_1_kms_key" {
  source = "github.com/lab-gke-se/modules//kms/key?ref=main"

  name     = "hpc-1-key"
  project  = local.projects["prj_dev_tenant_1"].project_id
  key_ring = module.hpc_1_kms_key_ring.id
  services = local.hpc_1_kms_services
}
