resource "google_artifact_registry_repository" "private-repo-docker-repository" {
  repository_id = "private-repo"
  format        = "DOCKER"
  docker_config {
    immutable_tags = true
  }
}

resource "google_artifact_registry_repository" "dockerhub-repository" {
  repository_id = "dockerhub"
  format        = "DOCKER"
  mode          = "REMOTE_REPOSITORY"
  remote_repository_config {
    description = "docker hub"
    docker_repository {
      public_repository = "DOCKER_HUB"
    }
  }
}

resource "google_artifact_registry_repository" "docker-repository" {
  repository_id = "devops-sandbox"
  format        = "DOCKER"
  mode          = "VIRTUAL_REPOSITORY"
  virtual_repository_config {
    upstream_policies {
      id         = "private-repo-upstream"
      repository = google_artifact_registry_repository.private-repo-docker-repository.id
      priority   = 20
    }
    upstream_policies {
      id         = "dockerhub-upstream"
      repository = google_artifact_registry_repository.dockerhub-repository.id
      priority   = 10
    }
  }
}
