data "aws_vpc" "default" {

    default = true
  
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}




resource "aws_security_group" "Jenkins" {
    vpc_id = data.aws_vpc.default.id
    ingress {
        from_port = 0
        to_port = 6535
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}

resource "aws_instance" "Jenkins" {
    ami = "ami-04726aaccec3fc9a2"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = data.aws_subnets.default.ids[0]
    vpc_security_group_ids = [ aws_security_group.Jenkins.id ]
    
  
}