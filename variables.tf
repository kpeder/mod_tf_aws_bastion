variable workstation_cidr {}

variable keypair {}

variable region {}

variable bastion_ami {
  type = "map"
  default {
    "us-east-1" = "ami-8446ff93"
    "us-west-2" = "ami-d732f0b7"
  }
}

variable type { default = "t2.micro" }
variable delonterm { default = true }
variable volsize { default = 40 }


variable "public_subnets" {
  type = "list"
}

variable "vpc_security_group_id" {}

variable "vpc_id" {}
