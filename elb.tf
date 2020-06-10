
# craeting Load Balnacer
 resource "aws_elb" "elb" {
  name     = "elb"
  internal = false
  subnets         = "${split(",",var.subnets)}"
  security_groups = ["${aws_security_group.elb_sg.id}"] 

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }
   
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

  tags = {
    Name = "${var.global_product}.${var.global_environment}-elb"
  }

}
