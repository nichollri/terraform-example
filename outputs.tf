output "Floating IP" {
  value = "ssh -lubuntu -i keypair ${aws_eip.demo.public_ip}"
}
