resource "aws_subnet" "public_subnets" {
  count = "${length(var.public_subnets)}"

  vpc_id = "${var.vpc_id}"
  availability_zone = "${data.aws_availability_zones.availability_zones.names[count.index]}"
  cidr_block = "${var.public_subnets[count.index]}"

  tags {
    Name = "${var.environment_name} public subnet ${count.index + 1}"
    resource_group = "${var.environment_name}"
  }
}

resource "aws_route_table" "public_routing_tables" {
  count = "${length(var.public_subnets)}"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.environment_name} public subnets routing table ${count.index + 1}"
    resource_group = "${var.environment_name}"
  }
}

resource "aws_route_table_association" "public_associations" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_routing_tables.*.id, count.index)}"
}