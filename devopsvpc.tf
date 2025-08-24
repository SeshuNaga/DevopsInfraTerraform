resource "aws_vpc" "devopsvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name ="devopsvpc"
    }
    
    
    
}

resource "aws_subnet" "devops_public_subnet" {
    vpc_id = aws_vpc.devopsvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name ="devops_public_subnet"
    }
    
    
  
}

resource "aws_internet_gateway" "devops_internet_gateway" {
    vpc_id = aws_vpc.devopsvpc.id
     tags = {
      Name ="devops_internet_gateway"
    }
    
    
  
}

resource "aws_route_table" "devops_route_table" {
    vpc_id = aws_vpc.devopsvpc.id
    tags = {
      Name ="devops_route_table"
    }
    route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_internet_gateway.id
    
  }
    
    
}

resource "aws_route_table_association" "devops_route_table_association" {
    route_table_id = aws_route_table.devops_route_table.id
    #gateway_id = aws_internet_gateway.devops_internet_gateway.id
    subnet_id = aws_subnet.devops_public_subnet.id
  
}

resource "aws_security_group" "devops_security_group" {
    vpc_id = aws_vpc.devopsvpc.id
    ingress {
        from_port = 0
        to_port = 65353
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

      ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

      ingress {
        from_port = 6443
        to_port = 6443
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
