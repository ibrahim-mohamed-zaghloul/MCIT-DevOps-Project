
resource "aws_ecr_repository" "ecr_repo_front" {
  name = "ecr_repo_front"

}

resource "aws_ecr_repository" "ecr_repo_back" {
  name = "ecr_repo_back"
}

