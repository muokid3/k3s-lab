variable "private_key_path" {
  description = "path to private key to inject into the instances to allow ssh"
  default     = "./ssh/id_rsa"
}

variable "public_key_path" {
  description = "path to public key to inject into the instances to allow ssh"
  default     = "./ssh/id_rsa.pub"
}

variable "key_name" {
  description = "master key for the lab"
  default     = "cp-key"
}

variable "name" {
  description = "A name to be applied to make everything unique and personal"
}

variable "aws_region" {
  description = "Europe"
  default     = "eu-west-2"
}

variable "instance_type" {
  default = "t3.micro"
}


variable "vpc" {
  description = "VPC"
}

variable "az" {
  description = "Availability zone"
}


variable "bastian_sg_id" {
  description = "Bastian security group"
}


variable "workers_sg_id" {
  description = "workers security group id"
}


variable "owner" {
  description = "resource owner"
}


variable "project" {
  description = "project name"
}

variable "env" {
  description = "environment - i.e. dev, test, prod"
}

variable "workspace" {
  description = "terraform workspace"
}

variable "zone" {
  description = "route 53 zone"
}






