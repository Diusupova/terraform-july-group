terraform {
  backend "s3" {
    bucket = "damka-kaizen"
    key    = "kaizen1/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "lock-state"
  }
}