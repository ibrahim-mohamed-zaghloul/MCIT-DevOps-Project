
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


# # Main S3 bucket resource
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "depi-final"  # Replace with a globally unique bucket name

#   tags = {
#     Name        = "Terraform State Bucket"
#     Environment = "Dev"
#   }
# }

# # Separate resource for server-side encryption
# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_sse" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # Separate resource for versioning
# resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }
