# EKS Cluster Definition
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnet[0].id, 
      aws_subnet.private_subnet[1].id, 
      aws_subnet.public_subnet[0].id, 
      aws_subnet.public_subnet[1].id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy]
}

# IAM Role for the EKS Cluster
resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

# Policy Attachment for EKS Cluster Role
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

# IAM Role for Worker Nodes
resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Policy Attachments for Worker Nodes Role
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

# Launch Template for EKS Node Group
# resource "aws_launch_template" "eks_node_launch_template" {
#   name_prefix   = "eks-node-group-launch-template"
#   image_id      = "ami-0866a3c8686eaeeba"  # EKS optimized AMI (Replace with region-specific AMI if necessary)
#   instance_type = "t3.large"  # Instance type (consider using a variable)

#   network_interfaces {
#     associate_public_ip_address = false
#     security_groups             = [aws_security_group.alb_sg.id]  # Attach security group to nodes
#   }

#   key_name = var.key_name  # Replace with your SSH key
# }

# EKS Node Group Definition
resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = [
    aws_subnet.private_subnet[0].id, 
    aws_subnet.private_subnet[1].id
  ]
  
  capacity_type   = "ON_DEMAND"  # Capacity type (consider using a variable)

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "eks-test"
    source_security_groups = [aws_security_group.my_custom_sg.id]
  }


  update_config {
    max_unavailable = 1
  }

  tags = {
    "ENV" = "fp"  # Environment tags (consider using a variable for different environments)
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly
  ]
}
