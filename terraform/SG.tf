# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-nodes_security_group"
  description = "Allow inbound HTTP 80-8080 traffic"
  vpc_id     = aws_vpc.vpc.id # Replace with your VPC ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]  # Allow traffic from anywhere
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]  # Allow traffic from anywhere
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]  # Allow traffic from anywhere
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks  = ["0.0.0.0/0"]
  }
}

