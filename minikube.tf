resource "aws_instance" "minikube_server" {
    ami = "ami-04726aaccec3fc9a2"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.project_devil_security_group.id ]
    vpc_security_group_ids = [ aws_security_group.project_devil_security_group.id ]
    associate_public_ip_address = true
    subnet_id = aws_subnet.project_devil_public_subnet.id
    key_name = "seshu"
  
}