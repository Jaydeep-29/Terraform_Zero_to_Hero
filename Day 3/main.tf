provider "aws" {
    region = "eu-west-2"
  
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami_value = "ami-0a89c0e1fe86ef74e" # replace this
    instance_type_value = "t2.micro"
    subnet_id_value = "subnet-05de6470a5e4f1772" # replace this

  
}