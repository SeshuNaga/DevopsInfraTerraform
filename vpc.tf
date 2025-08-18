provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_vpc" "project_vpc" {

    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    
  tags = {
    Name ="project_vpc"
  }
}

resource "aws_subnet" "project_vpc_public_subnet" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
    Name ="project_vpc_public_subnet"
  }

}

resource "aws_internet_gateway" "project_vpc_internet_gateway" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
    Name ="project_vpc_internet_gateway"
  }

  
}

resource "aws_route_table" "project_vpc_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_vpc_internet_gateway.id
  }

  tags = {
    Name = "project-vpc-route-table"
  }
}


resource "aws_route_table_association" "project_vpc_route_table_association" {
    route_table_id = aws_route_table.project_vpc_route_table.id
    subnet_id = aws_subnet.project_vpc_public_subnet.id
    
}

resource "aws_security_group" "project_vpc_security_group" {

    vpc_id = aws_vpc.project_vpc.id
    tags = {
      Name ="project_vpc_security_group"
    }

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =   ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "project_vpc_aws_instance" {

    ami = "ami-0f58b397bc5c1f2e8"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.project_vpc_public_subnet.id
    vpc_security_group_ids = [aws_security_group.project_vpc_security_group.id]
    associate_public_ip_address = true

    tags = {
      Name ="project_vpc_aws_instance"
    }
  
}
  

