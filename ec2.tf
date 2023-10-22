
resource "aws_instance" "jenkins" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.small"
  key_name      = "tf-key-pair-${random_id.server.hex}"
 #vpc_security_group_ids = "[aws_security_group.dynamicsg-${random_id.server.hex}.id]"
  tags = {
    Name        = "Jenkins"
    Envrionment = "TST"
    Application = "SAP"
    Owner       = "Khaja_living_legend"
  }
}
resource "random_id" "server" {
  byte_length = 8
}
resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair-${random_id.server.hex}"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair-${random_id.server.hex}"
}
resource "local_file" "hosts_cfg" {
  content = templatefile("inventory.tmpl",
    {
      ubuntu_hosts = aws_instance.web.*.public_ip
    }
  )
  filename = "/home/devops/hosts"
}



output "server_private_ip" {
  value = aws_instance.web.private_ip
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
