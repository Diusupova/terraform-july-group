provider aws {
    region = "us-east-2"
}

# resource "null_resource" "cluster" {
#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   connection {
#     host = element(aws_instance.web.*.public_ip, 0)
#     type = "ssh"
#     user = "ec2-user"
#     private_key = file("~/.ssh/id_rsa")
#   }

#   provisioner "remote-exec" {
#     inline = [
#        "sudo yum install httpd -y",
#        "sudo systemctl start httpd",
#        "sudo systemctl enable httpd"
#     ]
#   }
# }















