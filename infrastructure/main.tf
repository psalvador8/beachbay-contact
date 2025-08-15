provider "aws" {
  region = var.aws_region
}

# Disable account-level Block Public Access
resource "aws_s3_account_public_access_block" "account" {
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# S3 bucket for frontend
resource "aws_s3_bucket" "website" {
  bucket = var.website_bucket_name
}

# Ownership controls so ACLs can be used (needed for public-read)
resource "aws_s3_bucket_ownership_controls" "website_acl" {
  bucket = aws_s3_bucket.website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Allow public ACLs/policies at the bucket level
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}



# Public read policy for website content
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}

# DynamoDB table for storing contact form inquiries
resource "aws_dynamodb_table" "inquiries" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST" # scales automatically, no need to provision capacity
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S" # String type
  }

  tags = {
    Name        = "BeachBay Contact Inquiries"
    Environment = "prod"
  }
}
