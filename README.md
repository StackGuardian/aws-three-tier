# Basic-deployment
<img height="30" src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white">
<img height="30" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white">
<br>
Terraform templates for the basic VM deployment which includes the IaaC for VPC, EC2, RDS, S3, and other services as per the requirement. 

## Infrastructure build by this IaaC
```
VPC ==> Subnets [Public, and private], RDS subnet group [public and private], IGW, Route Table
EC2 ==> EC2, EBS, EIP, SC
RDS ==> RDS, SC
```

## Visualization
![alt text](https://i.imgur.com/fikr6Qt.png)