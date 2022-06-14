# -- ec2/variables.tf --

variable "public_sg" {

}

variable "key_name" {

}
variable "public_key_path" {

}

variable "public_subnets" {

}
variable "instance_count" {
  type = number
}
variable "instance_type" {
  type = string
}
variable "ami" {
  type = string
}
variable "vol_size" {
  type = number
}
