resource "aws_nat_gateway" "ap_south_1b_nat_gateway" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.ap_south_1b_public.id}"
    depends_on = ["aws_internet_gateway.default"]
}