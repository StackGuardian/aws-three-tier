resource "aws_efs_file_system" "demoefs" {
  creation_token = "demoefs"
  encrypted = "true"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name= "demoefs"
}
}

resource "aws_efs_backup_policy" "demoefs" {
  file_system_id = aws_efs_file_system.demoefs.id
  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "demoefs_mountpoint_a" {
  depends_on = [ aws_efs_file_system.demoefs ]
  file_system_id = aws_efs_file_system.demoefs.id
  subnet_id = aws_subnet.public-subnet[0].id
}
resource "aws_efs_mount_target" "demoefs_mountpoint_b" {
  depends_on = [ aws_efs_file_system.demoefs ]
  file_system_id = aws_efs_file_system.demoefs.id
  subnet_id = aws_subnet.public-subnet[1].id
}

resource "aws_efs_mount_target" "demoefs_mountpoint_c" {
  depends_on = [ aws_efs_file_system.demoefs ]
  file_system_id = aws_efs_file_system.demoefs.id
  subnet_id = aws_subnet.public-subnet[2].id
}

#Second EFS

resource "aws_efs_file_system" "demoefs2" {
  creation_token = "demoefs2"
  encrypted = "true"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name= "demoefs2"
}
}

resource "aws_efs_backup_policy" "demoefs2" {
  file_system_id = aws_efs_file_system.demoefs2.id
  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "demoefs2_mountpoint_a" {
  depends_on = [ aws_efs_file_system.demoefs2 ]
  file_system_id = aws_efs_file_system.demoefs2.id
  subnet_id = aws_subnet.public-subnet[0].id
}
resource "aws_efs_mount_target" "demoefs2_mountpoint_b" {
  depends_on = [ aws_efs_file_system.demoefs2 ]
  file_system_id = aws_efs_file_system.demoefs2.id
  subnet_id = aws_subnet.public-subnet[1].id
}
resource "aws_efs_mount_target" "demoefs2_mountpoint_c" {
  depends_on = [ aws_efs_file_system.demoefs2 ]
  file_system_id = aws_efs_file_system.demoefs2.id
  subnet_id = aws_subnet.public-subnet[2].id
}