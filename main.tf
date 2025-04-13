# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  registry_auth {
    address     = "docker.io"
    username   = "sharvik40"               # Логин можно оставить, если он не секретный
    password   = var.dockerhub_token       # Используем переменную
  }
}

resource "docker_image" "local" {
  name         = "sharvik40/nginx-app:latest"
  keep_locally = true
}

resource "null_resource" "docker_push" {
  triggers = {
    image_id = docker_image.local.id
  }

  provisioner "local-exec" {
    command = "docker push sharvik40/nginx-app:latest"
  }
}
