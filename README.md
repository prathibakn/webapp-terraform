
Pre-requisites:

1. AWS account with access key/secret access key
2. Terraform installed

run `terraform plan` to review and `terraform apply` to run the plan and create the infrastructure, and `terraform destroy` to destroy

# Sample web application AWS Infrastructure plan

1. VPC with its IGW
2. Subnets. Public for Bastion host and NAT instance. Private for webserver and RDS.
3. NAT instance with attached Elastic IP. Routes outbound traffic from private subnet instance to internet.
4. Route table associations. public subnet points to IGW and private subnet points to NAT for outbound connections
5. Security groups. For webserver, RDS, bastion host, ELB, and NAT
6. Bastion host for developers SSH connection to EC2 instances in private subnet.
7. RDS instance - Mysql
