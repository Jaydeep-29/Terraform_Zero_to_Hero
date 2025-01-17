# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2" #  set yor desire region  
}

resource "aws_instance" "this" {
  ami                     = "ami-0a89c0e1fe86ef74e" # specify appropriate AMI ID
  instance_type           = "t2.micro"
  subnet_id = "subnet-05de6470a5e4f1772"    # specify your subnet ID
  key_name = "DemoKeyPair"   # specify your keypair
}