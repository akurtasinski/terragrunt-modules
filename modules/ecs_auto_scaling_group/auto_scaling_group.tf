data "aws_ami" "ecs_ami" {
  count = "${length(var.skip) > 0 ? 0 : 1}"

  filter {
    name = "name"
    values = ["amzn-ami-${var.ecs_ami_version}-amazon-ecs-optimized"]
  }

  owners = ["591542846629"]
}

resource "aws_launch_configuration" "launch_conf" {
  count = "${length(var.skip) > 0 ? 0 : 1}"

  name_prefix = "${var.environment_name}-ecs"
  image_id = "${data.aws_ami.ecs_ami.id}"
  instance_type = "${var.lc_instance_type}"
  security_groups = [
    "${aws_security_group.ecs_ec2_security_group.id}"
  ]
  key_name = "${aws_key_pair.ecs_key.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance_profile.name}"


  lifecycle {
    create_before_destroy = true
  }

  user_data = <<EOF
#!/bin/bash

echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config

# Re-create the docker0 bridge and setup a different CIDR so it does not conflict with legacy VPCs
DOCKER_INTERFACE_CIDR="192.168.100.0/24"

sudo ip link add docker0 type bridge
sudo ip addr add "$DOCKER_INTERFACE_CIDR" dev docker0
sudo ip link set dev docker0 up

EOF
}

resource "aws_autoscaling_group" "asg" {
  count = "${length(var.skip) > 0 ? 0 : 1}"

  name_prefix = "${var.environment_name}-${aws_launch_configuration.launch_conf.name}-autoscaling-group"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  min_elb_capacity = "${var.min_size}"
  health_check_type = "ELB"
  desired_capacity = "${var.desired_capacity}"
  launch_configuration = "${aws_launch_configuration.launch_conf.name}"
  vpc_zone_identifier = ["${var.ec2_subnet_ids}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key = "Name"
    value = "${var.environment_name}-ecs-ec2"
    propagate_at_launch = "true"
  }

  tag {
    key = "resource_group"
    value = "${var.environment_name}"
    propagate_at_launch = true
  }
}
