resource "aws_instance" "jenkins_server" {
    ami = "ami-04726aaccec3fc9a2"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.devops_public_subnet.id
    key_name = "seshu"
    associate_public_ip_address = true
    security_groups = [ aws_security_group.devops_security_group.id ]
    
  
}