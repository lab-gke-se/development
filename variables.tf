variable "networks" {
  type = map(object({
    shared_vpc_host       = bool
    routing_mode          = string
    delete_default_routes = bool
    subnetworks = map(object({
      ip_cidr_range            = string
      region                   = string
      private_ip_google_access = string
      secondary_ip_ranges      = map(string)
    }))
  }))
}
