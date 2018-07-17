resource "aws_alb" "web" {
  load_balancer_type = "application"
  name               = "${var.alb_web["name"]}"
  internal           = true
  ip_address_type    = "ipv4"
  idle_timeout       = "${var.alb_web["idle_timeout"]}"

  subnets = [
    "${aws_subnet.private.0.id}",
    "${aws_subnet.private.1.id}",
  ]

  security_groups = [
    "${aws_security_group.sg_tf_sample.id}",
  ]

  tags {
    Name    = "${var.alb_web["name"]}"
    Role    = "${var.alb_web["role"]}"
    Segment = "${var.alb_web["segment"]}"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.web.arn}"
  protocol          = "${var.alb_listener_http["protocol"]}"
  port              = "${var.alb_listener_http["port"]}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.web.arn}"
  }
}

resource "aws_alb_target_group" "web" {
  name                 = "${var.target_group_web["name"]}"
  protocol             = "${var.target_group_web["protocol"]}"
  port                 = "${var.target_group_web["port"]}"
  vpc_id               = "${aws_vpc.vpc_tf_sample.id}"
  deregistration_delay = "${var.target_group_web["deregistration_delay"]}"

  health_check {
    protocol            = "${var.target_group_web["protocol"]}"
    path                = "${var.target_group_web["path"]}"
    healthy_threshold   = "${var.target_group_web["healthy_threshold"]}"
    unhealthy_threshold = "${var.target_group_web["unhealthy_threshold"]}"
    timeout             = "${var.target_group_web["timeout"]}"
    interval            = "${var.target_group_web["interval"]}"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = "${var.target_group_web["cookie_duration"]}"
  }

  tags {
    Name    = "${var.target_group_web["name"]}"
    Role    = "${var.target_group_web["role"]}"
    Segment = "${var.target_group_web["segment"]}"
  }
}

resource "aws_alb_target_group_attachment" "web" {
  count            = 10
  target_group_arn = "${aws_alb_target_group.web.arn}"
  target_id        = "${element(aws_instance.web.*.id,count.index)}"
}
