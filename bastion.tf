# Bastion host to help ssh into private subnet instances
resource "aws_instance" "bastion" {
  ami = "${lookup(var.amis, "bastion")}"
  instance_type = "${lookup(var.instance_types, "bastion")}"
  subnet_id = "${aws_subnet.ap_south_1b_public.id}"
  key_name = "${var.key_pair}"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true
  tags = { 
    Name = "Bastion Host or jump server"
  }
  lifecycle { create_before_destroy = true }
  user_data = "${file("ec2_user_data.txt")}"
}