resource "aws_instance" "webaz1" {
    ami = "${lookup(var.amis, "web_server")}"
    instance_type = "${lookup(var.instance_types, "web_server")}"
    subnet_id = "${aws_subnet.ap_south_1a_private_fe.id}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
    user_data = "${file("ec2_user_data.txt")}"
     key_name = "${var.key_pair}"
    root_block_device = {
      volume_type = "gp2"
      volume_size = 30
    }
    tags = { 
      Name = "Front end  web server for AZ1"
    }
}

resource "aws_instance" "webaz2" {
    ami = "${lookup(var.amis, "web_server")}"
    instance_type = "${lookup(var.instance_types, "web_server")}"
    subnet_id = "${aws_subnet.ap_south_1b_private.id}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
    user_data = "${file("ec2_user_data.txt")}"
     key_name = "${var.key_pair}"
    root_block_device = {
      volume_type = "gp2"
      volume_size =  30
    }
    tags = { 
      Name = "Front end  web server for AZ2"
    }
}