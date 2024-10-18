#network

vpc_cidr_block            = "10.0.0.0/16"
public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]

availability_zones = ["eu-north-1a", "eu-north-1b"]

#EC2-ECR

region     = "eu-north-1"
key_name   = "ubuntu_jenkins.pem"
ami        = "ami-08eb150f611ca277f" 
account_id = "376129884375"

#EKS

cluster_name = "eks_cluster"
