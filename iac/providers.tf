# Set the required provider and versions
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      source = "registry.opentofu.org/kreuzwerker/docker"
      version = "4.6.0"
    }
  }
}

# Configure the docker provider
provider "docker" {
}

