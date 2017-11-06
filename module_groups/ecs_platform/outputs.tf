output "ecs_cluster_name" {
  value = "${module.ecs_cluster.ecs_cluster_name}"
}

output "log_group_name" {
  value = "${module.log_group.log_group_name}"
}

output "public_load_balancer_fqdn" {
  value = "${module.public_load_balancer.public_load_balancer_fqdn}"
}

output "target_group_arn" {
  value = "${module.public_load_balancer.target_group_arn}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}