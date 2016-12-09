resource "null_resource" "bastion_provisioner" {

  # execute this resource if the instance id changes
  triggers {
    instance_id = "${aws_instance.bastion.id}"
  }

  # tag the instance
  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${aws_instance.bastion.id} --tags Key=Name,Value=${aws_instance.bastion.private_dns} Key=Role,Value=VPC_BASTION Key=Tier,Value=Deployment"
  }
}

