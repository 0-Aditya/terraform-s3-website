output "website_url" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}

output "bucket_name" {
  value = aws_s3_bucket.website_bucket.id
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}