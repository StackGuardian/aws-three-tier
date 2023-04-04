#Login Credentials 
aws_access_key = "XXXXXXXXXXXXXXXXXXXXX"
aws_secret_key = "XXXXXXXXXXXXXXXXXXXXX"
aws_region = "us-east-1"

#Project Details
project_name = "UAT"
env = "uat"

#Network Variables
vpc_cidr = "10.2.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets_cidrs = ["10.2.0.0/24", "10.2.1.0/24", "10.2.2.0/24"]
private_subnets_cidrs = ["10.2.3.0/24", "10.2.4.0/24", "10.2.5.0/24"]

#EC2 Instance Variables
instance_type = "t2.micro"
root_block_size_ebs = "20"

#RDS Variables
create_rds = false
allowed_cidr_rds = ["10.2.0.0/16"]
rds_storage = 20
rds_engine = "postgres"
rds_engine_version = "14"
rds_instance_class = "db.t3.micro"
rds_db_name = "uatdb"
rds_master_un = "uatdb"
#rds_master_password = "123test123"