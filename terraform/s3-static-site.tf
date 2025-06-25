resource "aws_s3_bucket" "static_site" {
  bucket = "nx-poc-static-martingerlero"
  
  tags = {
    Owner   = "Martin Gerlero"
    Purpose = "Static Website PoC"
  }
}

# Esto establece que el dueño del bucket es dueño de todos los objetos, deshabilitando las ACLs.
resource "aws_s3_bucket_ownership_controls" "static_site_ownership" {
  bucket = aws_s3_bucket.static_site.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Esto bloquea todo el acceso público EXCEPTO el que se defina explícitamente en la política del bucket.
resource "aws_s3_bucket_public_access_block" "static_site_access_block" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = true
  block_public_policy     = false # Se pone en 'false' para que nuestra política SÍ funcione
  ignore_public_acls      = true
  restrict_public_buckets = false # Se pone en 'false' para que nuestra política SÍ funcione
}

resource "aws_s3_bucket_website_configuration" "static_site_website" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
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
  
  # Esta dependencia asegura que los controles de propiedad se apliquen antes que la política.
  depends_on = [aws_s3_bucket_ownership_controls.static_site_ownership]
}

resource "aws_s3_object" "html_file" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "../index.html" # Asegúrate de que este path sea correcto
  content_type = "text/html"
  # Se elimina la línea 'acl = "public-read"'
}
