# resource "aws_db_subnet_group" "rds_sn_group" {
#     name = "rds_sn_group"
#     subnet_ids = ["${aws_subnet.ap_south_1a_private_be.id}", "${aws_subnet.ap_south_1b_private.id}"]
#     tags {
#         Name = "My DB subnet group"
#     }
# }

# resource "aws_db_instance" "demo-app-qa" {
#   allocated_storage    = 20
#   engine               = "mysql"
#   engine_version       = "5.6.27"
#   instance_class       = "${lookup(var.instance_types, "rds")}"
#   name                 = "demodatabase"
#   username             = "root"
#   password             = "password"
#   multi_az             = false
#   vpc_security_group_ids = ["${aws_security_group.rds.id}"]
#   availability_zone = "${var.az1}"
#   db_subnet_group_name = "${aws_db_subnet_group.rds_sn_group.name}"
#   parameter_group_name = "default.mysql5.6"
# }

