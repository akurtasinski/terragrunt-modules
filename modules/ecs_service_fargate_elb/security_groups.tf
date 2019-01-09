resource "aws_security_group" "app_worker" {
  name = "${var.environment_name} PackManager App Workers"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.environment_name} PackManager App Workers"
    resource_group = "${var.environment_name}"
  }
}

resource "aws_security_group_rule" "app_allow_egress_to_everywhere" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  security_group_id = "${aws_security_group.app_worker.id}"

  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "app_allow_ingress_from_vpc" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  security_group_id = "${aws_security_group.app_worker.id}"

  cidr_blocks = [ "${var.vpc_cidr}" ]
}