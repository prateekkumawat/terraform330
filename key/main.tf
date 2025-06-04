resource "tls_private_key" "use1ins1" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "use1key" {
  key_name = var.key_details
  public_key = tls_private_key.use1ins1.public_key_openssh
} 

# key download in your local system
resource "local_file" "use1ins1key1" {
   filename = var.filename
   content = tls_private_key.use1ins1.private_key_pem
}
