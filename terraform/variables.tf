# network variables

variable "region" {
  description = "The AWS region to create resources in."
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
}

variable "public_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones"
}

variable "account_id" {
  description = "An AWS Account ID."
}

# ec2 variables

variable "key_name" {
  description = "The name of the SSH key pair."
}


variable "ami" {
  description = "The name of the SSH key pair."
}


# EKS Variables

variable "cluster_name" {
  description = "The name of the EKS cluster."
}

