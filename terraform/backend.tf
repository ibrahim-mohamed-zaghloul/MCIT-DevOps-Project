
terraform {
  backend "s3" {
    bucket         = "depi-final"   # Reference the created bucket
    key            = "global/s3/terraform.tfstate"          # Path to store the state file in the bucket
    region         = "us-east-1"                           # Replace with your bucket's region
    encrypt        = true                                  # Encrypt the state file
    dynamodb_table = "terraform-locking"  # Reference the created DynamoDB table
  }
}
