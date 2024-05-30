# resource "google_dns_managed_zone" "example-zone" {
#   project     = local.projects.prj_dev_network.project_id
#   name        = "test-deny"
#   dns_name    = "test-deny-${random_id.rnd.hex}.com."
#   description = "Test DNS zone"
#   labels = {
#     foo = "bar"
#   }

#   visibility = "private"

#   private_visibility_config {
#     networks {
#       network_url = "projects/prj-dev-network-9sq0/global/networks/dev-network"
#     }
#   }
# }

# resource "random_id" "rnd" {
#   byte_length = 4
# }
