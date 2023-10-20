terraform {
  backend "s3" {
    bucket = "nagios-project"
    key    = "group3/terraform.tfstate"
    region = "us-east-2"
    
  }
}
