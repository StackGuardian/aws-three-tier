#Key Pair for the EC2 access
resource "aws_key_pair" "devops-key" {
  key_name   = "${var.project_name}-${var.env}-devops"
  public_key = "ssh-rsa XXXXXXXXXXXXXXXXXXX== PUBLIC-KEY@example.com"
}

#Retriving AMI for the EC2
data "aws_ami" "ubuntu-22-04lts" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] #Canonical
}

#Security Group to be attached to the EC2
resource "aws_security_group" "ec2-sc" {
  name   = "${var.project_name}-${var.env}-sc"
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Allow http traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Allow https traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description      = "Outgoing traffic of any protocol and port to any IP address"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name       = "${var.project_name}-${var.env}-sc"
    Project    = var.project_name
    Enviroment = var.env
  }
}
#EC2 instance 
resource "aws_instance" "ec2-instance" {
  ami           = data.aws_ami.ubuntu-22-04lts.id
  instance_type = var.instance_type
  key_name      = "${var.project_name}-${var.env}-devops"

  vpc_security_group_ids = [aws_security_group.ec2-sc.id]
  subnet_id              = aws_subnet.public-subnet[0].id
  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_block_size_ebs
    tags = {
      Name       = "${var.project_name}-${var.env} EBS"
      Project    = var.project_name
      Enviroment = var.env
    }
  }
  tags = {
    Name       = "${var.project_name}-${var.env}"
    Project    = var.project_name
    Enviroment = var.env
  }
}

#ElasticIP
resource "aws_eip" "ec2-eip" {
  vpc = true
  tags = {
    Name       = "${var.project_name}-${var.env}-EIP"
    Project    = var.project_name
    Enviroment = var.env

  }
}

#Associating eip to ec2 
resource "aws_eip_association" "ec2-eip-asso" {
  instance_id   = aws_instance.ec2-instance.id
  allocation_id = aws_eip.ec2-eip.id
}

# Public IP of EC2
output "elastic_ip" {
  value = aws_eip.ec2-eip.public_ip
}