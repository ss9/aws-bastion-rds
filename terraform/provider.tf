terraform {
  required_version = "~>1.0.7"
}


provider "aws" {
  version = "~> 3.38.0"
  region  = var.aws_region
  profile = var.aws_profile
  shared_credentials_file = var.aws_shared_credentials_file
}
