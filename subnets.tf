# Sales Ninja aPublic Subnets
resource "aws_subnet" "ap_south_1b_public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "${var.az2}"
    depends_on = ["aws_internet_gateway.default"]
    tags {
        Name = "Public Subnet for ${var.az2}"
    }
}

resource "aws_subnet" "ap_south_1a_public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "10.0.5.0/24"
    availability_zone = "${var.az1}"
    depends_on = ["aws_internet_gateway.default"]
    tags {
        Name = "Public Subnet for ${var.az1}"
    }
}

# Sales Ninja Private Subnets
resource "aws_subnet" "ap_south_1b_private" {
    vpc_id = "${aws_vpc.default.id}"
#    cidr_block = "${lookup(var.public_subnet_cidr, var.az2)}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.az2}"
    map_public_ip_on_launch = false
    depends_on = ["aws_nat_gateway.ap_south_1b_nat_gateway"]
    tags {
        Name = "Private Subnet for ${var.az2}"
    }
}

# Sales Ninja Private Subnets
resource "aws_subnet" "ap_south_1a_private_fe" {
    vpc_id = "${aws_vpc.default.id}"
#    cidr_block = "${lookup(var.private_subnet_cidr, var.az1)}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "${var.az1}"
    map_public_ip_on_launch = false
    depends_on = ["aws_nat_gateway.ap_south_1b_nat_gateway"]
    tags {
        Name = "Private Subnet for ${var.az1}"
    }
}

# Sales Ninja Private Subnets
resource "aws_subnet" "ap_south_1a_private_be" {
    vpc_id = "${aws_vpc.default.id}"
#    cidr_block = "${lookup(var.private_subnet_cidr, var.az1)}"
    cidr_block = "10.0.3.0/24"
    availability_zone = "${var.az1}"
    map_public_ip_on_launch = false
    depends_on = ["aws_nat_gateway.ap_south_1b_nat_gateway"]
    tags {
        Name = "Private Subnet for ${var.az1}"
    }
}


# Associate Public subnets with the Nat main route table
resource "aws_route_table_association" "public1" {
    subnet_id = "${aws_subnet.ap_south_1b_public.id}"
    route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "public2" {
    subnet_id = "${aws_subnet.ap_south_1a_public.id}"
    route_table_id = "${aws_route_table.public.id}"
}



# Associate Private Subnets to the Main Route
resource "aws_route_table_association" "private1" {
    subnet_id = "${aws_subnet.ap_south_1b_private.id}"
    route_table_id = "${aws_vpc.default.main_route_table_id}"
}

resource "aws_route_table_association" "private2" {
    subnet_id = "${aws_subnet.ap_south_1a_private_fe.id}"
    route_table_id = "${aws_vpc.default.main_route_table_id}"
}

resource "aws_route_table_association" "private3" {
    subnet_id = "${aws_subnet.ap_south_1a_private_be.id}"
    route_table_id = "${aws_vpc.default.main_route_table_id}"
}

