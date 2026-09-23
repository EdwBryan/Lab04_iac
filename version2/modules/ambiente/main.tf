# Redes aisladas por ambiente
resource "docker_network" "frontend_net" {
  name = "${var.environment}-frontend-net"
}

resource "docker_network" "backend_net" {
  name = "${var.environment}-backend-net"
}

# Imágenes
resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_image" "backend" {
  name = "node:18-alpine"
}

resource "docker_image" "postgres" {
  name = "postgres:15-alpine"
}

# Base de datos
resource "docker_container" "bd" {
  name  = "bd-${var.environment}"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_PASSWORD=postgres",
    "POSTGRES_DB=${var.environment}db"
  ]

  networks_advanced {
    name = docker_network.backend_net.name
  }

  ports {
    internal = 5432
    external = var.db_port
  }
}

# Backend (Conectado a ambas redes)
resource "docker_container" "api" {
  name  = "api-${var.environment}"
  image = docker_image.backend.image_id

  networks_advanced {
    name = docker_network.frontend_net.name
  }

  networks_advanced {
    name = docker_network.backend_net.name
  }

  ports {
    internal = 3000
    external = var.api_port
  }
}

# Frontend
resource "docker_container" "web" {
  name  = "web-${var.environment}"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.frontend_net.name
  }

  ports {
    internal = 80
    external = var.web_port
  }
}

# Despliegue del ambiente DEV
module "dev_environment" {
  source      = "./modules/ambiente"
  environment = "dev"
  web_port    = var.dev_web_port
  api_port    = var.dev_api_port
  db_port     = var.dev_db_port
}

# Despliegue del ambiente QA
module "qa_environment" {
  source      = "./modules/ambiente"
  environment = "qa"
  web_port    = var.qa_web_port
  api_port    = var.qa_api_port
  db_port     = var.qa_db_port
}