# Start a container
resource "docker_container" "nginx" {
  name  = "nginx-iac-lab04"
  image = docker_image.nginx.image_id
  ports {
    internal = var.web_server_port.prod
    external = var.web_server_port.qa
  }
}

# Find the latest Ubuntu precise image.
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

output "image_id" {
  value = docker_image.nginx.image_id
}