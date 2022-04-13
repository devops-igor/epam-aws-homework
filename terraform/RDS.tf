# Provide RDS instance
resource "aws_db_instance" "rds" {
    identifier             = "aws-homework-rds"
    allocated_storage      = 5
    storage_type           = "gp2"
    engine                 = "mysql"
    engine_version         = "5.7"
    instance_class         = "db.t2.micro"
    db_name                = var.db_name
    username               = var.db_username
    password               = var.db_password
    parameter_group_name   = "default.mysql5.7"
    skip_final_snapshot    = true
    multi_az               = false
    vpc_security_group_ids = var.security_group_id

    tags = {
        owner = var.tag_owner
        Name = "aws-homework-rds"
    }
}