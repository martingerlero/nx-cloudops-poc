# Define el proveedor de nube
provider "aws" {
  region = "us-east-1"
}

# Define un bucket S3 simple
resource "aws_s3_bucket" "app_bucket" {
  bucket = "nx-poc-data-martingerlero"

  tags = {
    Owner       = "Martin Gerlero"
    Purpose     = "PoC for Naranja X"
  }
}
