provider "aws" {
    region = "eu-west-2"
  
}

variable "ami" {
    description = "this is AMI for the instance"
  
}

variable "instance_type" {
    description = "this is type for the instance"
  
}

resource "aws_instance" "example" {

    ami = var.ami
    instance_type = var.instance_type
  
}