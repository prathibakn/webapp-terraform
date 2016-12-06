#  VPC
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags {
        Name = "demo-app-vpc",
        Env = "dev"
    }
}

# VPC Internet gateway
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name = "demo-app-vpc-igw"
    }    
}

# Create a Elastic IP for the Nat Gateway
resource "aws_eip" "nat" {
  vpc = true
}

# Modify the Main Route table used by Private Subnets to point to NAT gateway
resource "aws_route" "main" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
 
  nat_gateway_id         = "${aws_nat_gateway.ap_south_1b_nat_gateway.id}"
}

# Custom Route table for Public subnets connected to IGW
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
    tags {
        Name = "Demo app Public Subnet Route Table"
    }
}

