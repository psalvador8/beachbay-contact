output "website_endpoint" {
  description = "Public URL of the static website"
  value       = aws_s3_bucket_website_configuration.website_config.website_endpoint
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.bucket
}

output "http_api_endpoint" {
  value       = aws_apigatewayv2_api.http_api.api_endpoint
  description = "Public HTTPS endpoint for contact form submission"
}
