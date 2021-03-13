
variable "name" {
  description = "A name to be applied to make everything unique and personal"
}

variable "zone" {
  description = "route 53 zone"
}

variable "bastian_sg_id" {
  description = "bastion sg"
}

variable "vpc" {
  description = "the vpc to connect to"
}

variable "az" {
  description = "availability zones"
}

variable "aws_region" {
  description = "aws region "
  default = "eu-west-2"
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

variable "key_name" {
  description = "master key for the lab"
  default     = "lab-key"
}

variable "instance_type" {
  description = "type of instance"
  default     = "t3.micro"
}

variable "private_key_path" {
  description = "path to private key to inject into the instances to allow ssh"
  default     = "./ssh/id_rsa"
}

variable "public_key_path" {
  description = "path to public key to inject into the instances to allow ssh"
  default     = "./ssh/id_rsa.pub"
}





