terraform {
  required_providers {
    aws = {
      sourve = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region = "us-west-2"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "cigna-ng-app"
  acl = "public-read"

  attach_policy = true
  policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::cigna-ng-app/*",
      "Principal": "*"
    }
  ]
}
EOF

  website = {
    index_document = "index.html"
    error_document = "index.html"
  }
}