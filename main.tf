provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "aws" {
  ami           = "ami-0eab6d73b98b38574" # Amazon Linux 2 in ap-south-1
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-demo"
  }
}
