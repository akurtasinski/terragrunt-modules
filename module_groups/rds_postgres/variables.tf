variable "db_allocated_storage" {
  default = "8"
}

variable "db_name" {
}

variable "db_password" {
}

variable "db_username" {
}

variable "db_snapshot_identifier" {
  default = ""
}

variable "engine_version" {
}

variable "environment_name" {
}

variable "instance_class" {
}

variable "parameter_group_name" {
}

variable "private_rds_subnets" {
  type    = list(string)
  default = []
}

variable "production_mode" {
}

variable "skip" {
  default = ""
}

variable "vpc_cidr" {
}

variable "vpc_id" {
}

