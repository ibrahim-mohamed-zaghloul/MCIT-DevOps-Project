
#public-ec2_instance

resource "aws_instance" "public_ec2" {

  ami = var.ami
  instance_type = "t3.medium"
  subnet_id = aws_subnet.public_subnet.0.id
  associate_public_ip_address = true
  key_name = "ubuntu_jenkins"

  vpc_security_group_ids = [
    aws_security_group.bastion_host_sg.id 
  ]

  tags = {
    Name = "public-ec2"
  }
}

output "public-IPv4" {

    value = aws_instance.public_ec2.public_ip

}
