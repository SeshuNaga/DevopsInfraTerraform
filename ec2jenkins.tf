

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_vpc" "default" {
   default = true
}

resource "aws_security_group" "jenkins_sg" {

    vpc_id = data.aws_vpc.default.id
    
    ingress {
        from_port = 0
        to_port = 65353
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}

resource "aws_instance" "ec2jenkins" {
    ami = "ami-002ae468154bd9510"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.jenkins_sg.id ]
    subnet_id = data.aws_subnets.default.ids[0]
    key_name = "seshu"

    

    tags = {
      Name = "Jenkins Server"
    }
    
    

  
}