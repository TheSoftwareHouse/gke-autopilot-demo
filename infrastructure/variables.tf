variable "project_id" {
  description = "The project ID to deploy into"
  type        = string
  default     = "tsh-devops-sandbox"
}
variable "region" {
  description = "The region to deploy into"
  type        = string
  default     = "europe-central2"
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "devops-sandbox-vpc"
}

variable "default_labels" {
  description = "The default labels to apply to all resources"
  type        = map(string)
  default = {
    Created_by = "wwojcik"
    Env        = "dev"
    Team       = "devops"
  }
}
variable "kubernetes_cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "tsh-devops-sandbox"

}
variable "kubernetes_version" {
  description = "The version of Kubernetes to use"
  type        = string
  default     = "latest"
}

variable "kubernetes_master_authorized_networks" {
  description = "The list of master authorized networks"
  type = list(object({
    display_name = string
    cidr_block   = string
  }))
  default = [
    {
      display_name = "tsh-office"
      cidr_block   = "188.123.220.10/32"
    },
    {
      display_name = "wwojcik-home"
      cidr_block   = "188.123.197.222/32"
  }]
}

variable "sync_repo" {
  type        = string
  description = "git URL for the repo which will be sync'ed into the cluster via Config Management"
  default     = "https://github.com/TheSoftwareHouse/gke-autopilot-demo"
}

variable "sync_branch" {
  type        = string
  description = "the git branch in the repo to sync"
  default     = "main"
}

variable "policy_dir" {
  type        = string
  description = "the root directory in the repo branch that contains the resources."
  default     = "deployments"
}
