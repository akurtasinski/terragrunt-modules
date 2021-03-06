output "vpc_id" {
  #https://github.com/hashicorp/terraform/issues/16726
  value = element(concat(aws_vpc.vpc.*.id, [""]), 0)
}

output "vpc_cidr" {
  #https://github.com/hashicorp/terraform/issues/16726
  value = element(concat(aws_vpc.vpc.*.cidr_block, [""]), 0)
}

output "internet_gw_id" {
  #https://github.com/hashicorp/terraform/issues/16726
  value = element(concat(aws_internet_gateway.gw.*.id, [""]), 0)
}

