terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.13.0"
    }
  }
}

provider "docker" {}

# Nginx Image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Nginx Container
resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx_server"
  ports {
    internal = 80
    external = 8080
  }

  provisioner "local-exec" {
    command = "docker cp /tmp/file.txt nginx_server:/usr/share/nginx/html/"
  }
}

# Apache (httpd) Image
resource "docker_image" "apache2" {
  name         = "httpd:latest"
  keep_locally = false
}

# Apache (httpd) Container
resource "docker_container" "apache2" {
  image = docker_image.apache2.name
  name  = "apache2_server"
  ports {
    internal = 70
    external = 7070
  }

  provisioner "local-exec" {
    command = "docker cp /tmp/file.txt apache2_server:/usr/local/apache2/htdocs/"
  }
}
