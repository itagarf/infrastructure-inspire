resource "aws_default_vpc" "inspire-vpc" {
  tags = {
    Name = "New Default VPC"
  }
}

resource "aws_instance" "inspire" {
    ami = "ami-01cae1550c0adea9c"
    instance_type = "t2.micro"
    tags = {
        Name = "Inspire"
        Description = "A terraform-provisioned web server"
    }
    
    vpc_security_group_ids = [ aws_security_group.inspire.id ]
    provisioner "local-exec" {
      on_failure = continue
      command = "echo Instance ${aws_instance.inspire.public_ip} Created! > location.txt"
    }
}



resource "aws_security_group" "new-inspire-sg" {
  name = "new-inspire-sg"
  description = "Allow SSH access from internet"
  vpc_id = aws_default_vpc.inspire-vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output publicip {
    value = aws_instance.inspire.public_ip 
}