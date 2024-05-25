
provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "wihomet-terraform-state-wiliot"
    key    = "wihoemt/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "wihomet-lock-table"  
    # Uncomment these lines if you need to access the bucket through a custom endpoint
    # endpoint        = "s3.custom.endpoint"
    # skip_credentials_validation = true
    # skip_metadata_api_check     = true
    # force_path_style             = true
  }
}



# Define VPC
resource "aws_vpc" "wihoemt-vpc" {
    cidr_block = "10.0.0.0/16"
}

# Define Subnets
resource "aws_subnet" "wihoemt-subnet" {
    vpc_id                  = aws_vpc.wihoemt-vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
}

# Define Security Groups
resource "aws_security_group" "wihoemt-security-group" {
    name        = "wihoemt-security-group"
    description = "Allow HTTP inbound traffic"
    vpc_id      = aws_vpc.wihoemt-vpc.id

    # Define ingress rules
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Define egress rules
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Define Routing Tables
resource "aws_route_table" "wihoemt-route-table" {
    vpc_id = aws_vpc.wihoemt-vpc.id
}


# Define IAM Role
resource "aws_iam_role" "wihoemt_eks_role" {
    name = "wihomet-eks-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# Define EKS Cluster
resource "aws_eks_cluster" "wihomet-eks-cluster" {
    name     = "wihoemt-eks-cluster"
    role_arn = aws_iam_role.wihoemt_eks_role.arn
    version  = "1.21"
    vpc_config {
        subnet_ids = [aws_subnet.wihoemt-subnet.id]
    }
}

# Define ECR Repository
resource "aws_ecr_repository" "wihomet-ecr-repo" {
    name = "wihomet-ecr-repo"
}