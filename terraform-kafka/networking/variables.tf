# -- networking/variables.tf --


variable "vpc_cidr" {
  type = string
}

# this is sourced from root/variables.tf 
variable "public_cidrs" {
  type = list(any)
}
variable "access_ip" {
  type = string
}

variable "security_groups" {}