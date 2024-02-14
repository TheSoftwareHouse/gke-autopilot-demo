module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "= 9.0"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name               = var.network_name
      subnet_ip                 = "10.2.204.0/22"
      subnet_region             = var.region
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.1
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"

      tags = var.default_labels
    }
  ]

  secondary_ranges = {
    (var.network_name) = [
      {
        range_name    = local.kubernetes_subnetwork_pods_range_name
        ip_cidr_range = "10.184.0.0/14"
      },
      {
        range_name    = local.kubernetes_subnetwork_services_range_name
        ip_cidr_range = "10.188.0.0/20"
      }
    ]
  }

  routes = []
}
