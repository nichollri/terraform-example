resource "tls_private_key" "demo" {
  algorithm = "RSA"
  rsa_bits = 4096

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.demo.private_key_pem}\" > keypair"
  }

  provisioner "local-exec" {
    command = "chmod 600 keypair"
  }
}

resource "aws_key_pair" "demo" {
  key_name = "demo-keypair"
  public_key = "${tls_private_key.demo.public_key_openssh}"
}
