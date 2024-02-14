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
}
resource "google_gke_hub_feature" "servicemesh_acm_feature" {
  name     = "servicemesh"
  location = "global"
  provider = google-beta
}

resource "google_gke_hub_feature_membership" "feature_member" {
  provider   = google-beta
  location   = "global"
  feature    = "configmanagement"
  membership = google_gke_hub_membership.membership.membership_id
  mesh {
    management = "MANAGEMENT_AUTOMATIC"
  }
  configmanagement {
    version = "1.8.0"
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
    google_gke_hub_feature.configmanagement_acm_feature,
    google_gke_hub_feature.servicemesh_acm_feature
  ]
}
