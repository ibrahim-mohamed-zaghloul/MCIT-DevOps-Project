
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-locking"
  billing_mode = "PAY_PER_REQUEST"  # Autoscale billing mode
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Dev"
  }
}
