**Usage:

    module "bastion" {

      source = "github.com/kpeder/mod_tf_aws_bastion"

      keypair = "${var.keypair}"
      region = "us-west-2"
      workstation_cidr = "${var.workstation_cidr}"

      # default ami is Ubuntu Trusty, user 'ubuntu'
      # uncomment below to use your own AMI, specifying region
      # multiple regions can be specified, one AMI per region

      #bastion_ami["us-west-2"] = "ami-abcd1234"

      # use variables or literal strings, can reference relevant outputs form VPC module
      # only one bastion per module instance will deploy, even if multiple subnets are provided
      # (element 0 is selected from the list)
      public_subnets = [ "subnet-abcd1234"[, "subnet-dcba4321" ...] ]
      vpc_security_group_id = "sg-1234abcd"
      vpc_id = "vpc-abcd1234"

      type = "t2.micro"
      delonterm = true
      volsize = 40

    }

