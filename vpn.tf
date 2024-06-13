resource "google_compute_router" "dev_network_router" {
  project = local.projects.prj_dev_network.project_id
  name    = "ha-vpn-dev-network"
  region  = "us-east4"
  network = module.network.dev-network.name
  bgp {
    asn = 64514
  }
}

resource "google_compute_router" "onpremise_router" {
  project = local.projects.prj_dev_network.project_id
  name    = "onpremise-router"
  region  = "us-east4"
  network = module.network.onpremise.name
  bgp {
    asn = 64515
  }
}

resource "google_compute_ha_vpn_gateway" "dev_network" {
  project = local.projects.prj_dev_network.project_id
  name    = "vpn-dev-network"
  region  = "us-east4"
  network = module.network.dev-network.id
}

resource "google_compute_ha_vpn_gateway" "onpremise" {
  project = local.projects.prj_dev_network.project_id
  name    = "vpn-onpremise"
  region  = "us-east4"
  network = module.network.onpremise.id
}

resource "google_compute_vpn_tunnel" "dev_network_onpremise_1" {
  project               = local.projects.prj_dev_network.project_id
  name                  = "vpn-tunnel-dev-network-onpremise-1"
  region                = "us-east4"
  vpn_gateway           = google_compute_ha_vpn_gateway.dev_network.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.onpremise.id
  shared_secret         = "shhh"
  router                = google_compute_router.dev_network_router.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "dev_network_onpremise_2" {
  project               = local.projects.prj_dev_network.project_id
  name                  = "vpn-tunnel-dev-network-onpremise-2"
  region                = "us-east4"
  vpn_gateway           = google_compute_ha_vpn_gateway.dev_network.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.onpremise.id
  shared_secret         = "shhh"
  router                = google_compute_router.dev_network_router.id
  vpn_gateway_interface = 1
}

resource "google_compute_vpn_tunnel" "onpremise_dev_network_1" {
  project               = local.projects.prj_dev_network.project_id
  name                  = "vpn-tunnel-onpremise-dev-network-1"
  region                = "us-east4"
  vpn_gateway           = google_compute_ha_vpn_gateway.onpremise.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.dev_network.id
  shared_secret         = "shhh"
  router                = google_compute_router.onpremise_router.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "onpremise_dev_network_2" {
  project               = local.projects.prj_dev_network.project_id
  name                  = "vpn-tunnel-onpremise-dev-network-2"
  region                = "us-east4"
  vpn_gateway           = google_compute_ha_vpn_gateway.onpremise.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.dev_network.id
  shared_secret         = "shhh"
  router                = google_compute_router.onpremise_router.id
  vpn_gateway_interface = 1
}

resource "google_compute_router_interface" "dev_network_onpremise_1" {
  project    = local.projects.prj_dev_network.project_id
  name       = "dev-network-onpremise-1"
  router     = google_compute_router.dev_network_router.name
  region     = "us-east4"
  ip_range   = "169.254.0.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.dev_network_onpremise_1.name
}

resource "google_compute_router_interface" "dev_network_onpremise_2" {
  project    = local.projects.prj_dev_network.project_id
  name       = "dev-network-onpremise-2"
  router     = google_compute_router.dev_network_router.name
  region     = "us-east4"
  ip_range   = "169.254.1.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.dev_network_onpremise_2.name
}

resource "google_compute_router_interface" "onpremise_dev_network_1" {
  project    = local.projects.prj_dev_network.project_id
  name       = "onpremise-dev-network-1"
  router     = google_compute_router.onpremise_router.name
  region     = "us-east4"
  ip_range   = "169.254.0.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.onpremise_dev_network_1.name
}

resource "google_compute_router_interface" "onpremise_dev_network_2" {
  project    = local.projects.prj_dev_network.project_id
  name       = "onpremise-dev-network-2"
  router     = google_compute_router.onpremise_router.name
  region     = "us-east4"
  ip_range   = "169.254.1.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.onpremise_dev_network_2.name
}

resource "google_compute_router_peer" "dev_network_onpremise_1" {
  project                   = local.projects.prj_dev_network.project_id
  name                      = "dev-network-onpremise-peer-1"
  router                    = google_compute_router.dev_network_router.name
  region                    = "us-east4"
  peer_ip_address           = "169.254.0.2"
  peer_asn                  = 64515
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.dev_network_onpremise_1.name
}

resource "google_compute_router_peer" "dev_network_onpremise_2" {
  project                   = local.projects.prj_dev_network.project_id
  name                      = "dev-network-onpremise-peer-2"
  router                    = google_compute_router.dev_network_router.name
  region                    = "us-east4"
  peer_ip_address           = "169.254.1.1"
  peer_asn                  = 64515
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.dev_network_onpremise_2.name
}

resource "google_compute_router_peer" "onpremise_dev_network_1" {
  project                   = local.projects.prj_dev_network.project_id
  name                      = "onpremise-dev-network-peer-1"
  router                    = google_compute_router.onpremise_router.name
  region                    = "us-east4"
  peer_ip_address           = "169.254.0.1"
  peer_asn                  = 64514
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.onpremise_dev_network_1.name
}

resource "google_compute_router_peer" "onpremise_dev_network_2" {
  project                   = local.projects.prj_dev_network.project_id
  name                      = "onpremise-dev-network-peer-2"
  router                    = google_compute_router.onpremise_router.name
  region                    = "us-east4"
  peer_ip_address           = "169.254.1.2"
  peer_asn                  = 64514
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.onpremise_dev_network_2.name
}
