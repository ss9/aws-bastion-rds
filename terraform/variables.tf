## Base
variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-northeast-1"
}

variable "aws_profile" {
  description = "AWS profile"
}

variable "aws_shared_credentials_file"{
  description = "AWS credentail file"
  default = "~/.aws/credentials"
}

variable "stack" {
  description = "Name of the stack."
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

### Bastion
variable "access_ip"{
  description = "Access IP for AWS"
}

variable "ssh_key_name"{
  description = "Access key for EC2"
}

### db
variable "db_name"{
  description = "DB name"
}

variable "db_username" {}

variable "db_password" {}

variable "engine" { default = "mysql" }

variable "engine_version" { default = "8.0.20" }

variable "db_instance" { default = "db.t2.micro" }