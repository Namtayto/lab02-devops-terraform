# Default Security Group for VPC
resource "aws_security_group" "vpc_default" {
  name        = "vpc-default-security-group"
  description = "Default Security Group for VPC"
  vpc_id      = var.vpc_id

  # Inbound rules
  ingress {
    description      = "Allow inbound traffic within the security group"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # All protocols
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Outbound rules
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # All protocols
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-default-security-group"
  }
}

# Output ---------------------------------------------------------
output "vpc_default_security_group_id" {
  value = aws_security_group.vpc_default.id
}
