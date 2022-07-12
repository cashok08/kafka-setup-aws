# -- rds/main.tf -- 

resource "aws_db_subnet_group" "scpay" {
  name = "scpay"
  subnet_ids = var.public_subnets
  tags = {
    "Name" = "scpayrds"
  }
}

resource "aws_db_parameter_group" "scpay" {
  name = "scpay"
  family = "postgres13"
  parameter {
    name = "log_connections"
    value = "1"
  }

}

// RDS Runs in Managed VPC
// Creates a Single RDS Postgres DB Instance in one AZ in a Region
resource "aws_db_instance" "scpay" {
  identifier = "scpay"
  instance_class = var.instance_type
  allocated_storage = 5
  engine = var.rds_engine_type
  engine_version = var.rds_engine_version
  username = var.rds_username
  password = var.rds_password
  db_subnet_group_name = aws_db_subnet_group.scpay.name
  vpc_security_group_ids = [var.public_sg]
  #vpc_security_group_ids = [var.public_sg.id]
  parameter_group_name = aws_db_parameter_group.scpay.name
  publicly_accessible = true
  skip_final_snapshot = true
}
// Creates a snapshot (fullbackup) manual in the same region 
// Comment this to delete the snapshot taken :)
/*
resource "aws_db_snapshot" "scpay" {
  db_instance_identifier = aws_db_instance.scpay.id
  db_snapshot_identifier = "testsnapshot1234"
}*/

