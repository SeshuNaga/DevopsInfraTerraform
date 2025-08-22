resource "aws_instance" "k3sworkernode" {
    ami = "ami-04726aaccec3fc9a2"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.project_devil_public_subnet.id
    security_groups = [ aws_security_group.project_devil_security_group.id ]
    vpc_security_group_ids = [ aws_security_group.project_devil_security_group.id ]
    key_name = "seshu"
    associate_public_ip_address = true
    
   
    
}