# Provide EFS and mountpoints in each subnet
resource "aws_efs_file_system" "efs" {
  creation_token   = "aws-homework-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  
  tags = {
    owner = var.tag_owner
    Name  = "aws-homework-efs"
   }
}

resource "aws_efs_mount_target" "efs-mt" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_group_id
}
