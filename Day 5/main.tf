provider "aws" {
    region = "eu-west-2"
  
}

variable "cidr" {
    default = "10.0.0.0/16"
  
}

resource "aws_key_pair" "example" {
    key_name = "terraform-demo-jd"
    public_key = file("E:/Learning/Terraform_zero_to_hero/terra-key.pub")
  
}

resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
  
}

resource "aws_subnet" "sub1" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "eu-west-2a"
    map_public_ip_on_launch = true
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
  
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "server" {
    ami = "ami-0a89c0e1fe86ef74e"
    instance_type = "t2.micro"
    key_name = aws_key_pair.example.key_name
    vpc_security_group_ids = [aws_security_group.webSg.id]
    subnet_id = aws_subnet.sub1.id



connection  {
    type = "ssh"
    user = "ubuntu"
    private_key = file("E:/Learning/Terraform_zero_to_hero/terra-key")
    host = self.public_ip
}

 provisioner "file" {
    source      = "E:/Learning/Terraform_zero_to_hero/Day 5/app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install django",
      "sudo python3 app.py &",
    ]
  }
}
