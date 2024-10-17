resource "aws_ecr_repository" "ecr_front" {
  name  = var.ecr_frontend_name
}

output "ecr_url_front" {
  value = aws_ecr_repository.ecr_front.repository_url
}

resource "aws_ecr_repository" "ecr_back" {
  name  = var.ecr_backend_name
}

output "ecr_url_back" {
  value = aws_ecr_repository.ecr_back.repository_url
}

