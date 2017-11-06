resource "aws_security_group" "ecs_lb_security_group" {
  name_prefix = "${var.environment_name}-lb-sg-"

  vpc_id = "${var.vpc_id}"

  # Accept all public HTTPS traffic
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }

  # Allows all outbound traffic
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 65535
    protocol = "tcp"
  }

  tags {
    Name = "${var.environment_name} load balancer security group"
    resource_group = "${var.environment_name}"
  }
}
