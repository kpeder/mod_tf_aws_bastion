resource "aws_instance" "bastion" {

  /* set the initial key for the instance */
  key_name = "${var.keypair}"

  /* select the appropriate AMI */
  ami = "${lookup(var.bastion_ami, var.region)}"

  /* specify the instance type for the role */
  instance_type = "${var.type}"

  /* specify the subnet for the instance, the first public subnet */
  subnet_id = "${element(var.public_subnets, 0)}"

  /* specify multiples security groups to the instance */
  vpc_security_group_ids = [ "${var.vpc_security_group_ids}, ${aws_security_group.bastion.id}" ]

  /* the root (OS) volume. delete the volume on termination */
  root_block_device {
    delete_on_termination = "${var.delonterm}"
    volume_size           = "${var.volsize}"
  }
}

resource "aws_security_group" "bastion" {
  name   = "bastion-inbound-sg-tf"
  vpc_id = "${var.vpc_id}"
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
