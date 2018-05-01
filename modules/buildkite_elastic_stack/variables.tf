variable "agents_per_instance" { default = 1 }
variable "buildkite_agent_token" { }
variable "instance_type" { }
variable "key_name" { }
variable "max_size" { }
variable "min_size" { default = 0 }
variable "scale_adjustment" { default = 0 }
variable "secrets_bucket" { }
variable "spot_price" { default = 0 }
variable "stack_ami_version" { default = "" }
variable "stack_name" { }
variable "stack_template_url" { }
