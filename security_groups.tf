# Define the AWS provider
provider "aws" {
  region = "ap-southeast-2"
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
