# -- rds/outputs.tf --

output "rds_hostname" {
  value = aws_db_instance.scpay.address
  #sensitive = true
}
output "rds_port" {
  value = aws_db_instance.scpay.port
  
}
output "rds_username" {
  value = aws_db_instance.scpay.username
}
