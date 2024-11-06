# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

# Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
}

# Route to allow Internet access for Public Subnet via Internet Gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# NAT Gateway for Private Subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id  # NAT Gateway must be in a public subnet
}

# Route Table for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
}

# Route to allow Internet access for Private Subnet via NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private.id
}

# Output for Internet Gateway ID
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

# Output for NAT Gateway ID
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}
