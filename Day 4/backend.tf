terraform {
  backend "s3" {
    bucket         = "jd-s3-demo-xyz" # change this
    key            = "jd/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}