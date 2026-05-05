packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.3.0"
    }
  }
}

variable "region" {
  default = "us-east-2"
}

source "amazon-ebs" "amazon_linux_2023" {
  region        = var.region
  instance_type = "t3.micro"
  ssh_username  = "ec2-user"

  source_ami_filter {
    filters = {
      name                = "al2023-ami-*-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }

    most_recent = true
    owners      = ["amazon"]
  }

  ami_name = "golden-ami-al2023-{{timestamp}}"

  tags = {
    Name        = "golden-ami-al2023"
    CreatedBy   = "Packer"
    Environment = "Dev"
  }
}

build {
  sources = ["source.amazon-ebs.amazon_linux_2023"]

  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y git wget unzip",
      "sudo dnf install -y docker",
      "sudo systemctl enable docker",
      "sudo systemctl start docker"
    ]
  }
}