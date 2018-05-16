resource "aws_instance" "demo1" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.demo.key_name}"
  vpc_security_group_ids = ["${aws_security_group.demo.id}"]
  subnet_id = "${aws_subnet.demo.id}"
}

#resource "null_resource" "webpage" {
#  triggers {
#    server = "${aws_instance.demo1.id}"
#  }
#
#  connection {
#    type = "ssh"
#    host = "${aws_eip.demo.public_ip}"
#    user = "ubuntu"
#    private_key = "${tls_private_key.demo.private_key_pem}"
#  }
#
#  provisioner "file" {
#    source = "files/index.html"
#    destination = "~/index.html"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "sudo cp ~/index.html /var/www/html/index.html"
#    ]
#  }
#}
