# Security Group for Bastion host
resource "aws_security_group" "bastion" {
  name = "Bastion Security Group"
  description = "Bastion security group"
  vpc_id = "${aws_vpc.default.id}"
  lifecycle { create_before_destroy = true }
  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    self = true
  }
  # Limit CIDR blocks to access the Bastion host. Add your Public IP here
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["156.107.33.122/32"]
  }
  # 
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { 
    Name = " Bastion Security Group"
  }  
}


# elb security group to access the ELB over HTTP/HTTPS
resource "aws_security_group" "elb" {
  name = "demo_app_elb_sg"
  description = "Elastic Load Balancer Instance SG"
  vpc_id = "${aws_vpc.default.id}"
  # HTTPS access from anywhere
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "Elastic Load Balancer Security Group"
  }
}

# Web Instance security group to allow access from Elastic Load Balancer
resource "aws_security_group" "web" {
  name = "web_instance_sg"
  description = "Web Instance SG"
  vpc_id = "${aws_vpc.default.id}"
  # SSH access from bastion host only
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
  }
  # HTTPS access from ELB
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }
  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "EC2 Instance Security Group"
  }
}

# RDS Instance security group to allow access from Web Instance
resource "aws_security_group" "rds" {
  name = "rds_sg"
  description = "RDS Instance SG"
  vpc_id = "${aws_vpc.default.id}"
  # Incoming request from web instance only
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
  }
  # outbound internet access -  TBD through NAT
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "RDS Instance Security Group"
  }
}

# Security group for NAT instance
resource "aws_security_group" "nat" {
    name = "vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"
    vpc_id = "${aws_vpc.default.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.web.id}", "${aws_security_group.rds.id}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.web.id}", "${aws_security_group.rds.id}"]
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "NAT Instance SG"
    }
}