# Public ips of EC2 instances
output "public_ip_0" {
    value = aws_instance.wordpress-servers[0].public_ip
}

output "public_ip_1" {
    value = aws_instance.wordpress-servers[1].public_ip
}

# EFS DNS name
output "efs_dns" {
    value = aws_efs_mount_target.efs-mt[0].dns_name
}

# Load Balancer DNS name
output "load_balancer_dns" {
    value = aws_lb.lb.dns_name
}

# RDS endpoint
output "rds_endpoint" {
    value = aws_db_instance.rds.endpoint
}