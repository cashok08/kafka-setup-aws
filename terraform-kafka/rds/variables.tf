# -- rds/variables.tf --

variable "instance_type" {
  type = string
}

variable "rds_engine_type" {
  type = string
}

variable "rds_engine_version" {
  type = string
}
variable "rds_username" {
  type = string
}
variable "rds_password" {
  sensitive = true
}
variable "public_subnets" {

}

variable "public_sg" {

}
