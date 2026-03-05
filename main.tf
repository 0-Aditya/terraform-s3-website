provider "aws" {
  region = var.aws_region
}

module "s3_static_website" {

  source = "./modules/s3-static-website"

  bucket_name    = var.bucket_name
  website_folder = var.website_folder
  index_file     = var.index_file
  error_file     = var.error_file
}

module "cloudfront_distribution" {

  source = "./modules/cloudfront-distribution"

  origin_domain = module.s3_static_website.bucket_regional_domain_name
  default_root_object = "index.html"
}