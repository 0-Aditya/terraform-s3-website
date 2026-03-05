resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "website_config" {

  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = var.index_file
  }

  error_document {
    key = var.error_file
  }
}

resource "aws_s3_object" "website_files" {

  for_each = fileset(var.website_folder, "*")

  bucket = aws_s3_bucket.website_bucket.id
  key    = each.value
  source = "${var.website_folder}/${each.value}"

  etag = filemd5("${var.website_folder}/${each.value}")

  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      png  = "image/png"
      jpg  = "image/jpeg"
    },
    split(".", each.value)[length(split(".", each.value)) - 1],
    "text/plain"
  )
}

resource "aws_s3_bucket_public_access_block" "allow_public" {

  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_access" {

  bucket = aws_s3_bucket.website_bucket.id

  depends_on = [
    aws_s3_bucket_public_access_block.allow_public
  ]

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = "*"

        Action = [
          "s3:GetObject"
        ]

        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
      }
    ]
  })
}