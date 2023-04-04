# Basic-deployment
<img height="30" src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white">
<img height="30" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white">
<br>
Terraform templates for the basic VM deployment which includes the IaaC for VPC, EC2, RDS, S3, and other services as per the requirement. 
The assumption is that we need to create different enviroment for the projects (dev, qa, uat, and live). This approach utilizes the concepts of tfvars, and backend conf to accomplish the task. I have tried to incorporate DRY principle here. 

## Directory Structure

``` 
.
├── backend
│   ├── dev.conf
│   ├── live.conf
│   ├── qa.conf
│   └── uat.conf
├── ec2.tf
├── info
├── network.tf
├── providers.tf
├── rds-postgres.tf
├── README.md
├── variables
│   ├── terraform-dev.tfvars
│   ├── terraform-live.tfvars
│   ├── terraform-qa.tfvars
│   └── terraform-uat.tfvars
└── variable.tf
```
## Initialize the Secrets and Tokens in vault
- First initialize the bucket, and place the bucket name, along with region in each of the backend configuration files. 
- Also generate the access keys and secret key and place it in the variables (tfvars files)
At first we need to generate the token for the vault, and place the token in Jenkins enviroment or provider files. Vault are used to store the public_keys and the database master password. Make sure the key in the vault and terraform files are same. 

## Commands

## Initialize the Backend. 
- Configure the Bucket from the AWS Console. And update the bucket name in the backend/ directory.
- Update region if there is changes. 

## Dev Enviroment Setup  
```
$ terraform init -reconfigure -backend-config=backend/dev.conf
$ terraform plan -var-file=variables/dev.tfvars
$ terraform apply -var-file=variables/dev.tfvars --auto-approve
$ terraform destroy -var-file=variables/dev.tfvars --auto-approve
```
## QA Enviroment Setup
```
$ terraform init -reconfigure -backend-config=backend/qa.conf
$ terraform plan -var-file=variables/qa.tfvars
$ terraform apply -var-file=variables/qa.tfvars --auto-approve
$ terraform destroy -var-file=variables/qa.tfvars --auto-approve
```
## UAT Enviroment Setup
```
$ terraform init -reconfigure -backend-config=backend/uat.conf
$ terraform plan -var-file=variables/uat.tfvars
$ terraform apply -var-file=variables/uat.tfvars --auto-approve
$ terraform destroy -var-file=variables/uat.tfvars --auto-approve
```

## Live Enviroment Setup
```
$ terraform init -reconfigure -backend-config=backend/live.conf
$ terraform plan -var-file=variables/live.tfvars
$ terraform apply -var-file=variables/live.tfvars --auto-approve
$ terraform destroy -var-file=variables/live.tfvars --auto-approve
```

## Infrastructure build by this IaaC
```
VPC ==> Subnets [Public, and private], RDS subnet group [public and private], IGW, Route Table
EC2 ==> EC2, EBS, EIP, SC
RDS ==> RDS, SC
```

## Visualization
![alt text](https://i.imgur.com/fikr6Qt.png)