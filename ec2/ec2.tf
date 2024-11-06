# Creating key-pair on AWS using SSH-public key
resource "aws_key_pair" "deployer" {
  key_name   = var.key-name
  public_key = file("${path.module}/my-key.pub")
}

resource "aws_instance" "public_instance" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id

  # Gán Security Group cho instance
  vpc_security_group_ids = [var.public_sg_id]

  # Gán Key Pair để SSH qua Public EC2
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "Public EC2"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id

  #Security Group for instance
  vpc_security_group_ids = [var.private_sg_id]

  #Key Pair for SSH
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "Private EC2"
  }
}