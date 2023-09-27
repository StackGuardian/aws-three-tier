variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "AWS region for creating infstructure"
}

variable "project_name" {
  default     = "AWS"
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Project enviroment"
}

variable "vpc_cidr" {
  description = "CIDR block for vpc"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "Public subnets lists"
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "Private subnets lists"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availablity zones lists"
}

variable "instance_type" {
  type        = string
  description = "Instance specification"
  default     = "t2.micro"
}

variable "root_block_size_ebs" {
  type        = string
  description = "Root block size for EBS"
  default     = "20"
}

variable "create_rds" {
  description = "Whether to create RDS or not"
  default     = true
}

variable "allowed_cidr_rds" {
  type        = list(string)
  description = "Allowed CIDRs for connecting to RDS"
}

variable "rds_storage" {
  type        = number
  description = "Allocated storage for RDS"
  default     = 20
}

variable "rds_engine" {
  type        = string
  description = "Database engine"
}

variable "rds_engine_version" {
  type        = string
  description = "Major version release of RDS"
}

variable "rds_instance_class" {
  type        = string
  description = "Instance type for RDS"
  default     = "db.t3.micro"
}

variable "rds_db_name" {
  type        = string
  description = "Database name for RDS"
}

variable "rds_master_un" {
  type        = string
  description = "Master username for RDS"
}
variable "rds_master_password" {
  #type        = string
  type        = map(string)
  description = "Password for RDS"
  default = {
    "dev"  = "tf-secrets/dev"
    "qa"   = "tf-secrets/qa"
    "uat"  = "tf-secrets/uat"
    "live" = "tf-secrets/live"
  }
}