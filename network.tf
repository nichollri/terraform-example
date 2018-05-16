resource "aws_vpc" "demo" {
  cidr_block       = "10.0.0.0/24"
  tags {
    Name = "DemoVPC"
  }
}

resource "aws_subnet" "demo" {
  vpc_id     = "${aws_vpc.demo.id}"
  cidr_block = "10.0.0.0/24"
  tags {
    Name = "Demo"
  }
}

resource "aws_internet_gateway" "demo" {
  vpc_id     = "${aws_vpc.demo.id}"
}

resource "aws_route_table" "demo" {
  vpc_id = "${aws_vpc.demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo.id}"
  }
}

resource "aws_route_table_association" "demo" {
  subnet_id      = "${aws_subnet.demo.id}"
  route_table_id = "${aws_route_table.demo.id}"
}

resource "aws_eip" "demo" {
  instance = "${aws_instance.demo1.id}"
  vpc = true
  associate_with_private_ip = "${aws_instance.demo1.private_ip}"

  connection {
    type = "ssh"
    host = "${aws_eip.demo.public_ip}"
    user = "ubuntu"
    private_key = "${tls_private_key.demo.private_key_pem}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "DEBIAN_FRONTEND=noninteractive sudo apt-get upgrade -y",
      "DEBIAN_FRONTEND=noninteractive sudo apt-get install apache2 -y"
    ]
  }
}
