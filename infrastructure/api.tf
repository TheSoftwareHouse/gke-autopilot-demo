# Enable API services
resource "google_project_service" "services" {
  for_each = toset([
    "gkehub.googleapis.com",
    "container.googleapis.com",
    "connectgateway.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "anthos.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "meshconfig.googleapis.com"
  ])
  service            = each.value
  disable_on_destroy = false
}
