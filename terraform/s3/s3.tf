
resource "aws_s3_bucket" "terraform_state" {
  bucket = "depi-final"  # Replace with a globally unique bucket name

  versioning {
    enabled = true  # Enable versioning to keep track of state file changes
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}
