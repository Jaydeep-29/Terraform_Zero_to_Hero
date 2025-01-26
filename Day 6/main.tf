provider "aws" {
    region = "eu-west-2"
  
}

variable "ami" {
    description = "value"
  
}

variable "instance_type" {
    description = "value"
    type = map(string)

    default = {
      "dev" = "t2.micro"
      "prod" = "t2.medium"
      "stage" = "t2.large"
    }
  
}

module "ec2_instance" {
    source = "./Modules/EC2_Instance"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  
}