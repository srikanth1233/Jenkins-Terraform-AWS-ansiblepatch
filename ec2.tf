
resource "aws_instance" "jenkins" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.small"
  key_name      = "tf-key-pair"
  vpc_security_group_ids = [aws_security_group.dynamicsg.id]
  tags = {
    Name        = "Jenkins"
    Envrionment = "TST"
    Application = "SAP"
    Owner       = "Khaja_living_legend"
  }
}
resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair"
}
/*
resource "aws_instance" "Ansible" {
  ami           = "ami-051f7e7f6c2f40dc1"
  instance_type = "t2.micro"

  
  tags = {
    Name        = "Application Server"
    Envrionment = "TST"
    Application = "SAP"
    Owner       = "Khaja_living_legend"
  }
}
*/