resource "aws_s3_bucket" "static_site" {
  bucket = "nx-poc-static-martingerlero"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Owner   = "Martin Gerlero"
    Purpose = "Static Website PoC"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_site.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "html_file" {
  bucket       = aws_s3_bucket.static_site.bucket
  key          = "index.html"
  source       = "../index.html"
  content_type = "text/html"
  acl          = "public-read"
}
