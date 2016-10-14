variable "instance_type" {
  default = "t2.medium"
}

variable "region" {
  default = "eu-west-1"
}

variable "name" {
  default = "Codemotion"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

output "kafka_ip_address" {
  value = "${aws_instance.kafka.public_ip}"
}
