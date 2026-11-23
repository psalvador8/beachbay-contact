output "website_endpoint" {
  description = "HTTPS URL of the CloudFront distribution serving the private S3 website"
  value       = "https://${aws_cloudfront_distribution.website.domain_name}"
}

output "bucket_name" {
  description = "Name of the private S3 bucket"
  value       = aws_s3_bucket.website.bucket
}

output "http_api_endpoint" {
  value       = aws_apigatewayv2_api.http_api.api_endpoint
  description = "Public HTTPS endpoint for contact form submission"
}
