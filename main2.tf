

resource "aws_instance" "test1" {
  ami           = "ami-0eab6d73b98b38574" # Amazon Linux 2 in ap-south-1
  instance_type = "t2.micro"

  
}



output "test1" {
   value = {
    public_ip = aws_instance.test1.public_ip,
    private_ip = aws_instance.test1.private_ip
   }
   
   
}