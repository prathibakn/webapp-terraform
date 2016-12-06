# Create a new load balancer
resource "aws_elb" "demo_app_elb" {
  name = "demoappelb"
  subnets = ["${aws_subnet.ap_south_1a_public.id}", "${aws_subnet.ap_south_1b_public.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/srv/www/html/index.html"
    interval = 30
  }
  
  instances = ["${aws_instance.webaz1.id}", "${aws_instance.webaz2.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "demo_app_elb"
  }
}
