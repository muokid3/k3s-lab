
provider "aws" {
  profile = "muokid3"
  region  = var.region
}

module "vpc" {
  source    = "./vpc"
  name      = var.name
  owner     = var.owner
  project   = var.project
  env       = var.env
  workspace = var.workspace
}


module "bastian" {
  source = "./bastian"
  vpc    = module.vpc.id
  az     = module.vpc.az

  name             = var.name
  owner            = var.owner
  project          = var.project
  env              = var.env
  workspace        = var.workspace
  key_name         = var.key_name
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  instance_type    = var.instance_type
  aws_region       = var.region
}

module "workers" {
  source        = "./workers"
  vpc           = module.vpc.id
  az            = module.vpc.az
  zone          = module.vpc.zone
  bastian_sg_id = module.bastian.bastian_sg_id

  name             = var.name
  owner            = var.owner
  project          = var.project
  env              = var.env
  workspace        = var.workspace
  key_name         = var.key_name
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  instance_type    = var.instance_type
  aws_region       = var.region
}

module "control-plane" {
  source        = "./control-plane"
  vpc           = module.vpc.id
  az            = module.vpc.az
  zone          = module.vpc.zone
  bastian_sg_id = module.bastian.bastian_sg_id
  workers_sg_id = module.workers.workers_sg_id

  name             = var.name
  owner            = var.owner
  project          = var.project
  env              = var.env
  workspace        = var.workspace
  key_name         = var.key_name
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  instance_type    = var.instance_type
  aws_region       = var.region
}
