#provider

region = "us-east-1"

#ecr

ecr_frontend_name = "frontend_repo"
ecr_backend_name = "backend_repo"

#network

vpc_cidr = "10.0.0.0/16"
vpc_name = "three_tier_vpc"
igw_name = "three_tier_internet_gateway"
public_subnet_name = "three_tier_public_subnet"
public_subnet_cidr = "10.0.1.0/24"
public_route_table_name = "three_tier_public_route_table"
sg_name = "three_tier_security_group"

#iam_roles_nodes

iam_role_nodes_name = "iam_role_nodes_name_eks_cluster_three_tier_app"
eks_node_group_name = "node-group-three-tier-app"
iam_role_eks_cluster_name = "iam_role_eks_cluster_three_tier_app"
eks_cluster_name = "eks_cluster_three_tier_app"