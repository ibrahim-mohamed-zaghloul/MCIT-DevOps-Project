
#public-ec2_instance

resource "aws_instance" "public_ec2" {

  ami                  = var.ami
  instance_type        = "t3.medium"
  subnet_id            = aws_subnet.public_subnet.0.id
  key_name             = "us-east-1-aws-key"
  # iam_instance_profile = aws_iam_instance_profile.public_ec2_profile.name
  vpc_security_group_ids = [
    aws_security_group.bastion_host_sg.id
  ]


  tags = {
    Name = "public-ec2"
  }
  provisioner "file" {
    source      = "~/Desktop/new_repo/us-east-1-aws-key.pem" # Local path to the file
    destination = "/home/ubuntu/.ssh/us-east-1-aws-key.pem"  # Destination path on the EC2 instance
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/.ssh/us-east-1-aws-key.pem"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/Desktop/new_repo/us-east-1-aws-key.pem") # This is the private key used for SSH access
    host        = aws_instance.public_ec2.public_ip
  }
}

# resource "aws_iam_role" "public_ec2_role" {
#   name = "public_ec2_role"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "ec2-EKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.public_ec2_role.name
# }

# resource "aws_iam_role_policy_attachment" "ec2-EKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.public_ec2_role.name
# }

# resource "aws_iam_role_policy_attachment" "ec2-EC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.public_ec2_role.name
# }


# resource "aws_iam_instance_profile" "public_ec2_profile" {
#   name = "ec2_bastion_profile"
#   role = aws_iam_role.public_ec2_role.name
# }