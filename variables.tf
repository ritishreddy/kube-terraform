# Define the AWS provider
provider "aws" {
  region = "ap-southeast-2"
}

# VPC CIDR block variable
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

# Availability zones variable
variable "availability_zones" {
  default = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

# SSH public key variable
variable "ssh_public_key" {
  description = "The SSH public key for accessing EC2 instances."
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoZ3VfRnYBr1MvLz9MSXlI5dF2flk/pXOW/lFFmOEh6O7/CIutTQCePx+SMPvToE67psI9RBdJaK3g/SZ3f2L8gltj62y56nJROZVFK2IFx4/QmIY3NEtqIaNLzuzeWlDCutDl2ZrLDCCk/W8XJDaWf07BptlhVVIzXISCgWUiJ0Mgl83reh7hqG6Wnv16rHyqt18OLe3O+BuvAwmMpVuHNGynbEQOkg+eah131Lp90pT28LsssfFG1+4yPtrQLmKf/DpNW+xVo2Tujks5KShB7WLLYCw6H+gybUkW9S1JnfTObmKXCutk9JExAs3Fa/gK5ICzP60t9QCH2XbhA70F jenkins"
}

# Security group rules variable (allowing all traffic, not recommended for production)
variable "security_group_rules" {
  description = "A map of security group rules."
  type        = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    all_traffic = {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
