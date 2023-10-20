packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "example" {
  ami_name      = "google {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami = "ami-0df435f331839b2d6"
  ssh_username = "ec2-user"
  ssh_keypair_name = "parker"
  ssh_private_key_file = "~/.ssh/id_rsa"

  ami_regions = [
    "us-east-1",
    "us-east-2",
    "us-west-1"
  ]

  run_tags = {
    Name = "Golden Image"
  }
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.example"
  ]
  provisioner "shell" {
    script = "setup.sh"
  }

  provisioner "breakpoint" {
    note = "Please verify"
  }
}
    