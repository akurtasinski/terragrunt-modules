variable "db_allocated_storage" {
  default = "8"
}

variable "db_name" {
}

variable "db_password" {
}

variable "db_snapshot_identifier" {
  default = ""
}

variable "db_username" {
}

variable "engine_version" {
}

variable "environment_name" {
}

variable "instance_class" {
}

variable "parameter_group_name" {
}

variable "production_mode" {
}

variable "rds_subnet_ids" {
  type = list(string)
}

variable "skip" {
  default = ""
}

variable "vpc_cidr" {
}

variable "vpc_id" {
}

