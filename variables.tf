 variable "aws_access_key" { 
   description = "AWS access key"
   default = ""
 }

 variable "aws_secret_key" { 
   description = "AWS secret access key"
   default = ""
 }

variable "aws_region" { 
  description = "AWS region to host the VPC"
  default = "ap-south-1"
}

variable "vpc_cidr" {
    description = "VPC CIDR"
    default = "10.0.0.0/16"
}

variable "key_pair" {
  default = "demoappkeypair"
}

variable "public_subnet_cidr" {
    description = "Public Subnet CIDR"
    default = {
        ap-south-1a = "10.0.0.0/24"
        ap-south-1b = "10.0.1.0/24"
    }    
}


variable "az1" {
    default = "ap-south-1a"
}

variable "az2" {
    default = "ap-south-1b"
}

variable "private_subnet_cidr" {
    description = "Private Subnet CIDR"
    default = {
        ap-south-1a = "10.0.2.0/24"
        ap-south-1b = "10.0.3.0/24"
    }    
}

# Amazon linux AMIs for the regions
variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    bastion = "ami-34b4c05b"
    nat_instance = "ami-34b4c05b"
    web_server = "ami-34b4c05b"
  }
}

variable "instance_types" {
  description = "Base instance types to launch the instances with"
  default = {
    bastion = "t2.micro"
    nat_instance = "t2.micro"
    web_server = "t2.micro"
    rds = "db.t2.micro"
  }
}
