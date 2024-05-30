subnets = {
  dev-tenant-1-europe-west2 = {
    name                     = "dev-tenant-1"
    region                   = "europe-west2"
    ip_cidr_range            = "10.0.4.0/22"
    private_ip_google_access = true
  }
  dev-tenant-1-master = {
    name                     = "dev-tenant-1-master"
    region                   = "europe-west2"
    ip_cidr_range            = "10.60.0.0/17"
    private_ip_google_access = true
  }
  dev-tenant-1-nodes = {
    name                     = "dev-tenant-1-nodes"
    region                   = "europe-west2"
    ip_cidr_range            = "10.61.0.0/28"
    private_ip_google_access = true
  }
}

secondary_ranges = {
  dev-tenant-1 = [
    {
      range_name    = "dev-tenant-1-services"
      ip_cidr_range = "10.4.0.0/14"
    },
    {
      range_name    = "dev-tenant-1-pods"
      ip_cidr_range = "10.0.32.0/20"
    }
  ]
}


networks = {
  dev-network = {
    shared_vpc_host       = false
    routing_mode          = "REGIONAL"
    delete_default_routes = false
    subnetworks = {
      dev-tenant-1 = {
        ip_cidr_range         = "10.0.4.0/22"
        region                = "europe-west2"
        subnet_private_access = true
        secondary_ip_ranges = {
          dev-tenant-1-services = "10.4.0.0/14"
          dev-tenant-1-pods     = "10.0.32.0/20"
        }
      }
      dev-tenent-1-master = {
        ip_cidr_range = "10.60.0.0/17"
        region        = "europe-west2"
      }
      dev-tenent-1-nodes = {
        ip_cidr_range = "10.61.0.0/28"
        region        = "europe-west2"
      }
    }
  }
}


# + subnetwork = {
#     + description              = ""
#     + gateway_address          = "10.0.4.1"
#     + id                       = "projects/prj-dev-network-9sq0/regions/europe-west2/subnetworks/dev-tenant-1"
#     + internal_ipv6_prefix     = ""
#     + ip_cidr_range            = "10.0.4.0/22"
#     + name                     = "dev-tenant-1"
#     + network                  = "https://www.googleapis.com/compute/v1/projects/prj-dev-network-9sq0/global/networks/dev-network"
#     + private_ip_google_access = false
#     + project                  = "prj-dev-network-9sq0"
#     + region                   = "europe-west2"
#     + secondary_ip_range       = [
#         + {
#             + ip_cidr_range = "10.4.0.0/14"
#             + range_name    = "dev-tenant-1-pods"
#           },
#         + {
#             + ip_cidr_range = "10.0.32.0/20"
#             + range_name    = "dev-tenant-1-services"
#           },
#       ]
#     + self_link                = "https://www.googleapis.com/compute/v1/projects/prj-dev-network-9sq0/regions/europe-west2/subnetworks/dev-tenant-1"
#   }
# gcloud compute networks subnets create dev-tenant-1 
# --project prj-dev-network-9sq0 
# --network dev-network 
# --range 10.0.4.0/22 --region europe-west2 --secondary-range dev-tenant-1-services=10.0.32.0/20,
# dev-tenant-1-pods=10.4.0.0/14
