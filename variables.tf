variable workstation_cidr {}

variable keypair {}

variable region { default = "us-west-2" }

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


variable "public_subnets" { default = [] }         #list of public subnet ids for the target VPC
variable "vpc_security_group_ids" { default = [] } #list of security group ids to make the bastion member of
variable "vpc_id" {}                               #vpc id for the target VPC
