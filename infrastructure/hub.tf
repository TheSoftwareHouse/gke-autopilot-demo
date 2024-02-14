# Declare a fleet in the project
resource "google_gke_hub_fleet" "default" {
  display_name = "devops-sandbox"
  depends_on = [
    google_project_service.services
  ]
}



resource "google_gke_hub_membership" "membership" {
  provider      = google-beta
  membership_id = "membership-hub-${module.gke.name}"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${module.gke.cluster_id}"
    }
  }
}

resource "google_gke_hub_feature" "configmanagement_acm_feature" {
  name     = "configmanagement"
  location = "global"
  provider = google-beta
  depends_on = [
    google_project_service.services
  ]
}
resource "google_gke_hub_feature" "servicemesh_acm_feature" {
  name     = "servicemesh"
  location = "global"
  provider = google-beta
  depends_on = [
    google_project_service.services
  ]
}
# resource "google_gke_hub_feature" "policycontroller_acm_feature" {
#   name = "policycontroller"
#   location = "global"
#   provider = google-beta
#   depends_on = [
#     google_project_service.services
#   ]
# }
resource "google_gke_hub_feature_membership" "feature_member_policy_controller" {
  provider   = google-beta
  location   = "global"
  feature    = "policycontroller"
  membership = google_gke_hub_membership.membership.membership_id
  policycontroller {
    policy_controller_hub_config {
      install_spec = "INSTALL_SPEC_ENABLED"
    }
  }
  depends_on = [
    google_project_service.services,
  ]
}
resource "google_gke_hub_feature_membership" "feature_member_service_mesh" {
  provider   = google-beta
  location   = "global"
  feature    = google_gke_hub_feature.servicemesh_acm_feature.name
  membership = google_gke_hub_membership.membership.membership_id
  mesh {
    management = "MANAGEMENT_AUTOMATIC"
  }
  depends_on = [
    google_project_service.services,
    google_gke_hub_feature.servicemesh_acm_feature
  ]
}

resource "google_gke_hub_feature_membership" "feature_member" {
  provider   = google-beta
  location   = "global"
  feature    = google_gke_hub_feature.configmanagement_acm_feature.name
  membership = google_gke_hub_membership.membership.membership_id
  configmanagement {
    version = "1.17.1"
    config_sync {
      source_format = "unstructured"
      git {
        sync_repo      = var.sync_repo
        sync_branch    = var.sync_branch
        policy_dir     = var.policy_dir
        secret_type    = "none"
        sync_wait_secs = 600
      }
    }
  }
  depends_on = [
    google_project_service.services,
    google_gke_hub_feature.configmanagement_acm_feature,
  ]
}
