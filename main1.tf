provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "test2" {
  ami           = "ami-0eab6d73b98b38574" # Amazon Linux 2 in ap-south-1
  instance_type = "t2.micro"

  
}



output "test2" {
   value = {
    public_ip = aws_instance.test2.public_ip,
    private_ip = aws_instance.test2.private_ip
   }
   
   
}