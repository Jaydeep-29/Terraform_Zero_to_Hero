provider "aws" {
    region = "eu-west-2"
  
}

resource "aws_instance" "jd" {
    instance_type = "t2.micro"
    ami = "ami-0a89c0e1fe86ef74e"
    subnet_id = "subnet-05de6470a5e4f1772"
     
  
}

resource "aws_s3_bucket" "s3_bucket" {
     bucket = "jd-s3-demo-xyz" # change this
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform_lock"
  billing_mode   = "pay_per_request"
  hash_key       = "UserId"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}