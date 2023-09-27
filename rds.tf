resource "aws_security_group" "rds-sc" {
  name   = "${var.project_name}-${var.env}-rds-sc"
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "Allow 5432 port to connect to EC2"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_rds
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#RDS Instances
resource "aws_db_instance" "rds" {
  count                     = 3
  identifier                = "${var.project_name}-${var.env}-rds"
  allocated_storage         = var.rds_storage
  engine                    = var.rds_engine
  engine_version            = var.rds_engine_version
  instance_class            = var.rds_instance_class
  db_name                   = var.rds_db_name
  username                  = var.rds_master_un
  password                  = var.rds_master_password
  db_subnet_group_name      = aws_db_subnet_group.private-subnet-db.name #For private subnet
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.project_name}-${var.env}-${count.index}finalsnapshot"
  vpc_security_group_ids    = [aws_security_group.rds-sc.id]
  backup_retention_period   = 15
  maintenance_window        = "sun:00:00-Sun:03:00"
  backup_window             = "03:00-06:00"
  publicly_accessible       = false
  storage_type              = "gp2"
  tags = {
    Name       = "${var.project_name}-${var.env}-${count.index}-RDS"
    Project    = var.project_name
    Enviroment = var.env

  }
}