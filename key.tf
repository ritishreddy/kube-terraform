# Define the AWS provider
provider "aws" {
  region = "ap-southeast-2"
}

# Create an EC2 key pair
resource "aws_key_pair" "ritishvpc_key_pair" {
  key_name   = "ritish-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoZ3VfRnYBr1MvLz9MSXlI5dF2flk/pXOW/lFFmOEh6O7/CIutTQCePx+SMPvToE67psI9RBdJaK3g/SZ3f2L8gltj62y56nJROZVFK2IFx4/QmIY3NEtqIaNLzuzeWlDCutDl2ZrLDCCk/W8XJDaWf07BptlhVVIzXISCgWUiJ0Mgl83reh7hqG6Wnv16rHyqt18OLe3O+BuvAwmMpVuHNGynbEQOkg+eah131Lp90pT28LsssfFG1+4yPtrQLmKf/DpNW+xVo2Tujks5KShB7WLLYCw6H+gybUkW9S1JnfTObmKXCutk9JExAs3Fa/gK5ICzP60t9QCH2XbhA70F jenkins"
}
