# Security Group for Public Instance
resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  # Inbound rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["42.116.6.42/32"]  # Replace this IP with your IP
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PublicInstanceSecurityGroup"
  }
}

# Security Group for Private Instance
resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  # Inbound rule
  ingress {
    from_port              = 22
    to_port                = 22
    protocol               = "tcp"
    security_groups      = [aws_security_group.public_sg.id]  # Only allow from Public SG
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PrivateInstanceSecurityGroup"
  }
}

output "public_sg_id" {
  value       = aws_security_group.public_sg.id
  description = "Public EC2 Security Group ID"
}

output "private_sg_id" {
  value       = aws_security_group.private_sg.id
  description = "Public EC2 Security Group ID"
}
