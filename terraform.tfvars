networks = {
  onpremise = {
    shared_vpc_host       = false
    routing_mode          = "REGIONAL"
    delete_default_routes = true
    subnetworks = {
      pupi = {
        ip_cidr_range            = "161.124.14.0/24"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges      = {}
      }
      vdi = {
        ip_cidr_range            = "10.10.2.0/24"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges      = {}
      }
    }
  }

  dev-network = {
    shared_vpc_host       = false
    routing_mode          = "REGIONAL"
    delete_default_routes = true
    subnetworks = {
      dev-tenant-1 = {
        ip_cidr_range            = "10.0.4.0/22"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges = {
          dev-tenant-1-services = "10.4.0.0/14"
          dev-tenant-1-pods     = "10.0.32.0/20"
        }
      }
      tenant-gke = {
        ip_cidr_range            = "100.88.1.0/25"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges = {
          tenant-gke-services = "240.0.36.0/22"
          tenant-gke-pods     = "240.0.64.0/19"
        }
      }
      tenant-gke-1 = {
        ip_cidr_range            = "100.88.2.0/25"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges = {
          tenant-gke-services = "240.2.36.0/22"
          tenant-gke-pods     = "240.2.64.0/19"
        }
      }
      tenant-gke-private = {
        ip_cidr_range            = "10.10.1.0/25"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges = {
          tenant-gke-services = "240.1.36.0/22"
          tenant-gke-pods     = "240.1.64.0/19"
        }
      }
      tenant-gke-standard = {
        ip_cidr_range            = "100.88.3.0/25"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges = {
          tenant-gke-services = "240.3.36.0/22"
          tenant-gke-pods     = "240.3.64.0/19"
        }
      }
      tenant-gke-us-central1 = {
        ip_cidr_range            = "100.88.4.0/25"
        region                   = "us-central1"
        private_ip_google_access = true
        secondary_ip_ranges = {
          tenant-gke-services = "240.4.36.0/22"
          tenant-gke-pods     = "240.4.64.0/19"
        }
      }
      proxy = {
        ip_cidr_range            = "162.124.14.0/24"
        region                   = "us-east4"
        private_ip_google_access = true
        secondary_ip_ranges      = {}
      }
    }
  }
}