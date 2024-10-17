#iam_roles_nodes

resource "aws_iam_role" "iam_role_nodes" {
  name = var.iam_role_nodes_name

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.iam_role_nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.iam_role_nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.iam_role_nodes.name
}

resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name                = aws_eks_cluster.eks_3t_cluster.name
  addon_name                  = "aws-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  role       = aws_iam_role.iam_role_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

#Node_Group

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_3t_cluster.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = aws_iam_role.iam_role_nodes.arn
  subnet_ids      = [aws_subnet.public_subnet.id]

  capacity_type = "ON_DEMAND"
  instance_types = ["t2.medium"]


  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.ebs_csi_driver_policy_attachment
  ]
}


#iam_role_eks

resource "aws_iam_role" "iam_role_eks_3t_cluster" {
  name = var.iam_role_eks_cluster_name

  assume_role_policy = <<POLICY
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
POLICY
}

#iam_role_attachement

resource "aws_iam_role_policy_attachment" "role_policy_attachment_eks_3t_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.iam_role_eks_3t_cluster.name
}

#EKS_Cluster

resource "aws_eks_cluster" "eks_3t_cluster" {
  name = var.eks_cluster_name
  role_arn = aws_iam_role.iam_role_eks_3t_cluster.arn
  vpc_config {
    subnet_ids = [aws_subnet.public_subnet.id]  
  }

  depends_on = [ aws_iam_role_policy_attachment.role_policy_attachment_eks_3t_cluster ]
}