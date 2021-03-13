module "tags" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git"
  namespace   = var.name
  environment = var.env
  name        = format("%s.%s", var.name, var.env)
  delimiter   = "_"

  tags = {
    name      = "bastian"
    owner     = var.owner
    project   = var.project
    env       = var.env
    workspace = var.workspace
    comments  = "bastian"
  }
}


resource "aws_subnet" "bastian" {
  vpc_id                  = var.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.az[0]
  tags                    = module.tags.tags
}

variable "ing" {
  type = list(any)
  default = [
    { from = 80, to = 80 },
    { from = 8080, to = 8080 },
    { from = 443, to = 443 },
    { from = 22, to = 22 }
  ]
}

resource "aws_security_group" "bastian" {
  vpc_id = var.vpc.id
  tags   = module.tags.tags

  dynamic "ingress" {
    for_each = var.ing
    content {
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = ingress.value.from
      to_port     = ingress.value.to
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "bastian_keypair" {
  key_name   = format("%s%s", var.name, "_bastian_keypair")
  public_key = file(var.public_key_path)
}

data "aws_ami" "latest_bastian" {
  most_recent = true
  owners      = ["self"]
  name_regex  = "^${var.name}-k3s-server-\\d*$"

  filter {
    name   = "name"
    values = ["${var.name}-k3s-server-*"]
  }
}

resource "aws_instance" "bastian" {
  ami                    = data.aws_ami.latest_bastian.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.bastian.id
  vpc_security_group_ids = [aws_security_group.bastian.id]
  key_name               = aws_key_pair.bastian_keypair.id

  root_block_device {
    volume_size = 100
    volume_type = "gp2"
  }

  tags = module.tags.tags
}
