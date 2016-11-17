resource "aws_instance" "bastion" {

  /* set the initial key for the instance */
  key_name = "${var.keypair}"

  /* select the appropriate AMI */
  ami = "${lookup(var.bastion, var.region["primary"])}"

  /* specify the instance type for the role */
  instance_type = "${var.bastion["type"]}"

  /* specify the availability zone for the instance */
  subnet_id = "${element(module.vpc.public_subnets, 0)}" #how to abstract cleanly but integrate with the vpc module?

  /* specify multiples security groups to the instance */
  vpc_security_group_ids = [ "${module.vpc.default_security_group_id}", "${aws_security_group.bastion.id}" ] #same issue

  /* the root (OS) volume. delete the volume on termination */
  root_block_device {
    delete_on_termination = "${var.bastion["delonterm"]}"
    volume_size = "${var.bastion["volsize"]}"
  }

  /* determine whether to deploy this resource */
  count = "${var.bastion["deploy"]}"

}

resource "aws_security_group" "bastion" {
  name   = "bastion-inbound-sg-tf"
  vpc_id = "${module.vpc.vpc_id}" #same issue
}

resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.workstation_cidr}"]
  security_group_id = "${aws_security_group.bastion.id}"
}

output "bastion_dns" {
  value = "${aws_instance.bastion.public_dns}"
}
