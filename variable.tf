variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "AWS region for creating infstructure"
}

variable "project_name" {
  default     = "stack"
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Project enviroment"
  default     = "demo"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for vpc"
  default     = "10.5.0.0/16"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "Public subnets lists"
  default     = ["10.5.0.0/24", "10.5.1.0/24", "10.5.2.0/24"]
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "Private subnets lists"
  default     = ["10.5.3.0/24", "10.5.4.0/24", "10.5.5.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "Availablity zones lists"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "instance_type" {
  type        = string
  description = "Instance specification"
  default     = "t2.micro"
}

variable "public_key" {
  type = string
  description = "Public key to be associated with EC2 instance"
}

variable "root_block_size_ebs" {
  type        = string
  description = "Root block size for EBS"
  default     = "20"
}

/* variable "create_rds" {
  description = "Whether to create RDS or not"
  default     = true
} */

variable "allowed_cidr_rds" {
  type        = list(string)
  description = "Allowed CIDRs for connecting to RDS"
  default     = ["10.5.0.0/16"]
}

variable "rds_storage" {
  type        = number
  description = "Allocated storage for RDS"
  default     = 20
}

variable "rds_engine" {
  type        = string
  description = "Database engine"
  default     = "postgres"
}

variable "rds_engine_version" {
  type        = string
  description = "Major version release of RDS"
  default     = "14"
}

variable "rds_instance_class" {
  type        = string
  description = "Instance type for RDS"
  default     = "db.t3.micro"
}

variable "rds_db_name" {
  type        = string
  description = "Database name for RDS"
  default     = "demodb"
}

variable "rds_master_un" {
  type        = string
  description = "Master username for RDS"
  default     = "demodb"
}
variable "rds_master_password" {
  type        = string
  description = "Password for RDS"
}

variable "ecr_name" {
  type = string
  description = "Name of the ECR"
  default = "sgecr"
}

variable "ecr_name2" {
  type = string
  description = "Name of the ECR"
  default = "sgecr2"
}