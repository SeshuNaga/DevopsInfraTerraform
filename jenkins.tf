resource "aws_instance" "jenkins_server" {
    ami = "ami-04726aaccec3fc9a2"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.devops_public_subnet.id
    key_name = "seshu"
    associate_public_ip_address = true
    security_groups = [ aws_security_group.devops_security_group.id ]
    root_block_device {
    volume_size = 30        # 30 GiB
    volume_type = "gp3"     # General Purpose SSD
    iops        = 3000      # IOPS for gp3 (default: 3000)
    throughput  = 125       # Throughput in MB/s (optional, default 125)
    encrypted   = false     # keep unencrypted since you mentioned "Not encrypted"
  }
  
}