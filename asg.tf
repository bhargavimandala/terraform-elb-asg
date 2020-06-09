 resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "${var.ami_id}"
  instance_type = "${var.instance}"
  security_groups = ["${aws_security_group.elb_sg.id}"]

  lifecycle {
    create_before_destroy = true
  }
}


 resource "aws_autoscaling_group" "asg" {
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  min_size             = 2
  max_size             = 2
  load_balancers    = ["${aws_elb.elb.name}"]
  health_check_type = "EC2"
  vpc_zone_identifier = "${split(",",var.subnets)}"
  lifecycle {
    create_before_destroy = true
  }
}
