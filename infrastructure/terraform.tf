terraform {
  cloud {
    organization = "TSH"

    workspaces {
      project = "TSH_GCP"
      name    = "gcp-devops-sandbox"
    }
  }

}
