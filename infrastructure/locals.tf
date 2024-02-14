locals {
  kubernetes_subnetwork_pods_range_name     = "${var.kubernetes_cluster_name}-${var.network_name}-pods"
  kubernetes_subnetwork_services_range_name = "${var.kubernetes_cluster_name}-${var.network_name}-services"
}
