#provider

variable "region" {
  description = "the name of the region"
}

#ecr

variable "ecr_frontend_name" {
  description = "the name of the frontend repo"
}

variable "ecr_backend_name" {
  description = "the name of the backend repo"
}

#network

variable "vpc_cidr" {
  description = "the vpc cidr block range"
}

variable "vpc_name" {
  description = "the name of the vpc"
}

variable "igw_name" {
  description = "the name of the vpc"
}

variable "public_subnet_name" {
  description = "the name of the public subnet"
}

variable "public_subnet_cidr" {
  description = "the public subnet cidr block range"
}

variable "public_route_table_name" {
  description = "the name of the public route table"
}

variable "sg_name" {
  description = "the name of the security group"
}

#iam_roles_nodes

variable "iam_role_nodes_name" {
  description = "the name of the iam role of the nodes of the eks cluster"
}

#Node_Group

variable "iam_role_nodes_name" {
  description = "the name of the iam role of of the nodes of the eks cluster"
}


variable "eks_node_group_name" {
  description = "the name of the node group"
}

variable "iam_role_eks_cluster_name" {
  description = "the name of the iam role of the eks cluster"
}

variable "eks_cluster_name" {
  description = "the name of the eks cluster"
}
