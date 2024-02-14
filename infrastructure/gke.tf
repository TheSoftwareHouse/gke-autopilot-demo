module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster"
  version                         = "= v30.0"
  name                            = var.kubernetes_cluster_name
  project_id                      = var.project_id
  regional                        = true
  region                          = var.region
  kubernetes_version              = var.kubernetes_version
  network                         = module.vpc.network_name
  subnetwork                      = module.vpc.subnets_names[0]
  ip_range_pods                   = local.kubernetes_subnetwork_pods_range_name
  ip_range_services               = local.kubernetes_subnetwork_services_range_name
  enable_vertical_pod_autoscaling = true
  horizontal_pod_autoscaling      = true
  deletion_protection             = false
  master_authorized_networks      = var.kubernetes_master_authorized_networks
  grant_registry_access           = true
  //registry_project_ids            = [google_artifact_registry_repository.docker_repository.id]
}
