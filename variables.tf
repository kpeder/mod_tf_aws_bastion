  subnet_id = "${element(module.vpc.public_subnets, 0)}" #how to abstract cleanly but integrate with the vpc module?

  vpc_security_group_ids = [ "${module.vpc.default_security_group_id}", "${aws_security_group.bastion.id}" ] #same issue

  vpc_id = "${module.vpc.vpc_id}" #same issue

