module "runners_stack" {
  source = "../../modules/buildkite_elastic_stack"

  buildkite_agent_token = "${var.buildkite_agent_token}"
  instance_type = "${var.runner_instance_type}"
  key_name = "${aws_key_pair.key_pair.key_name}"
  max_size = "${var.runner_max_size}"
  scale_adjustment = "${var.runner_scale_adjustment}"
  spot_price = "${var.runner_spot_price}"
  stack_ami_version = "${var.stack_ami_version}"
  stack_config_env = "${var.stack_config_env}"
  stack_name = "${var.buildkite_env_name}-runners"
  stack_template_url = "${var.stack_template_url}"
}