provider "aws" {
  region = "${var.region}"
  profile = "calonso"
}

resource "aws_key_pair" "calonso" {
  key_name = "calonso-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8DJKdueX0I/QhSXknGIccd6VixhNE7Y6etMUdKTmbv7U6WPWjlx61TMj5yziI0AdBT9vu/owh855F1KblFWirIDnRZsmEUyfr/woZWJ774dqHEfyMpRHd/PeUM4oEZr3oep/8nSiRFS7ZU0QZAi8fvRSgoKJxQI+W87DD6QLUO9YW/SSyDDP3psXdHN5VRuIeGqlyFunemsxY7vp4kVIWxwsTMRc36nRkH9qYjl1XJ9WrPskocN6zEQRMX0VH/LsKa0A84LsIiY4mfCrWS4ZPlKBkf5dGgMLEcBHWXzFVeXSreyAn+bOelL63y3kPVFW+AV17n4GWauLuA4bU5EEUp/b3uGkdgePKP8avHTlCIuQBS/HsmFvMv1c9Fz7ZpS0kO/n6Uvn+Vl6/NgV/WJT5i5HxNk5LbwBwBpbT4m6TMAq5ckctFWVkLOCK3qipli6ImjW6z+G50Ly3NUm8kf5r4lcMnmQUi+LKEMES0O48LMOwgcfx3VADmH4dPXh6uAMTbXPYfx0nN4EFox2sJ3vSVZ+I4PMeVrM2xj5XdXXyP+vc5l1H2/PfGnrg1XUbmFw5uUfNkPTCooz2xJs4txrierdGSQyQaFEMP0U1pSyMLsPMFi5FVapWZXx8cs0mBuItC7++l9a732bZGMAKzDnEwyZ+gXfyL9IKmTOZ/MS6kw== calonso@jobandtalent.com"
}

module "network" {
  source     = "./network"
  name       = "${var.name}"
  cidr_block = "${var.cidr_block}"
}

resource "aws_security_group" "kafka" {
  name        = "kafka"
  vpc_id      = "${module.network.vpc_id}"
  description = "Kafka security group"

  tags {
    Name = "Kafka SG"
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.cidr_block}"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ami" {
  source        = "github.com/terraform-community-modules/tf_aws_ubuntu_ami/ebs"
  instance_type = "${var.instance_type}"
  region        = "${var.region}"
  distribution  = "trusty"
}

resource "aws_instance" "kafka" {
  ami                         = "${module.ami.ami_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.calonso.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.kafka.id}"]
  subnet_id                   = "${module.network.public_subnet_id}"
  associate_public_ip_address = true

  tags {
    Name      = "kafka"
  }
}
