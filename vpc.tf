resource "aws_vpc" "project_devil_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    

   tags = {
     Name ="project_devil_vpc"
   }
}

resource "aws_subnet" "project_devil_public_subnet" {
    vpc_id = aws_vpc.project_devil_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name ="project_devil_public_subnet"
    }

  
}

resource "aws_internet_gateway" "project_devil_internet_gateway" {
    vpc_id = aws_vpc.project_devil_vpc.id
    tags = {
      Name="project_devil_internet_gateway"
    }
  
}

resource "aws_route_table" "project_devil_route_table" {
  vpc_id = aws_vpc.project_devil_vpc.id
   tags = {
      Name="project_devil_route_table"
    }
  
}

resource "aws_route_table_association" "project_devil_route_table_association" {
    route_table_id = aws_route_table.project_devil_route_table.id
    gateway_id = aws_internet_gateway.project_devil_internet_gateway.id
   
    
  
}

resource "aws_security_group" "project_devil_security_group" {
    vpc_id = aws_vpc.project_devil_vpc.id
    ingress {
        from_port = 0
        to_port = 65353
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