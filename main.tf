# Define the AWS provider
provider "aws" {
  region = "ap-southeast-2"
}

# Create a VPC
resource "aws_vpc" "ritishvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "ritishvpc"
  }
}

# Define the availability zones
variable "availability_zones" {
  default = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

# Create subnets in different availability zones
resource "aws_subnet" "ritishvpc_subnets" {
  count = length(var.availability_zones)
  vpc_id     = aws_vpc.ritishvpc.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "ritishvpc-subnet-${element(var.availability_zones, count.index)}"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "ritishvpc_igw" {
  vpc_id = aws_vpc.ritishvpc.id
}

# Create a route table
resource "aws_route_table" "ritishvpc_route_table" {
  vpc_id = aws_vpc.ritishvpc.id
}

# Create a default route to the internet via the internet gateway
resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.ritishvpc_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ritishvpc_igw.id
}

# Create an EC2 key pair
resource "aws_key_pair" "ritishvpc_key_pair" {
  key_name   = "ritish-key-pair"
  public_key = "ssh-rsa ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoZ3VfRnYBr1MvLz9MSXlI5dF2flk/pXOW/lFFmOEh6O7/CIutTQCePx+SMPvToE67psI9RBdJaK3g/SZ3f2L8gltj62y56nJROZVFK2IFx4/QmIY3NEtqIaNLzuzeWlDCutDl2ZrLDCCk/W8XJDaWf07BptlhVVIzXISCgWUiJ0Mgl83reh7hqG6Wnv16rHyqt18OLe3O+BuvAwmMpVuHNGynbEQOkg+eah131Lp90pT28LsssfFG1+4yPtrQLmKf/DpNW+xVo2Tujks5KShB7WLLYCw6H+gybUkW9S1JnfTObmKXCutk9JExAs3Fa/gK5ICzP60t9QCH2XbhA70F jenkins"
}

# Create security groups for EC2 instances (allowing all traffic, not recommended for production)
resource "aws_security_group" "ritishvpc_security_group" {
  name        = "ritishvpc-security-group"
  description = "Security group for ritishvpc EC2 instances"

  # Allow all inbound traffic
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.ritishvpc.id
}

# Launch Ubuntu EC2 instances in the subnets
resource "aws_instance" "ritishvpc_instances" {
  count         = length(aws_subnet.ritishvpc_subnets)
  ami           = "ami-0310483fb2b488153"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.ritishvpc_subnets[count.index].id
  key_name      = aws_key_pair.ritishvpc_key_pair.key_name
  security_groups = [aws_security_group.ritishvpc_security_group.name]
  tags = {
    Name = "ritishvpc-instance-${count.index}"
  }
}
