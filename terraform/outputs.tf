#EC2

output "public-IPv4" {

  value = aws_instance.public_ec2.public_ip

}



#ECR

output "ecr_front_endpoint" {
  value = aws_ecr_repository.ecr_repo_front.repository_url
}

output "ecr_back_endpoint" {
  value = aws_ecr_repository.ecr_repo_back.repository_url
}

output "alb_security_group_id" {
  description = "The security group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}