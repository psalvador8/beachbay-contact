variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "website_bucket_name" {
  description = "S3 bucket name for hosting the frontend"
  type        = string
  default     = "beachbay-contact-miami-site"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "beachbay-contact-handler"
}

variable "lambda_zip_path" {
  description = "Path to packaged Lambda zip file"
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for storing inquiries"
  type        = string
  default     = "beachbay_inquiries"
}

variable "ses_sender_email" {
  description = "Verified SES sender email address"
  type        = string
}

variable "ses_notify_email" {
  description = "Hotel staff notification email"
  type        = string
}

