terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}
# ------------------------------------------------------------------------------
# IMÁGENES DOCKER
# ------------------------------------------------------------------------------
resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

resource "docker_image" "backend" {
  name         = "node:18-alpine"
  keep_locally = false
}

resource "docker_image" "postgres" {
  name         = "postgres:15-alpine"
  keep_locally = false
}
# ------------------------------------------------------------------------------
# REDES DOCKER (Aislamiento por capas)
# ------------------------------------------------------------------------------
# Redes DEV
resource "docker_network" "dev_frontend_net" {
  name = "dev-frontend-net"
}

resource "docker_network" "dev_backend_net" {
  name = "dev-backend-net"
}

# Redes QA
resource "docker_network" "qa_frontend_net" {
  name = "qa-frontend-net"
}

resource "docker_network" "qa_backend_net" {
  name = "qa-backend-net"
}