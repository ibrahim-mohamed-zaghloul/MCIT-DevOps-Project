
resource "aws_ecr_repository" "ecr_repo_front" {
  name = "ecr_repo_front"

}

resource "aws_ecr_repository" "ecr_repo_back" {
  name = "ecr_repo_back"
}

output "ecr_front_endpoint" {
  value = aws_ecr_repository.ecr_repo_front.repository_url
}

output "ecr_back_endpoint" {
  value = aws_ecr_repository.ecr_repo_back.repository_url
}