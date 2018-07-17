resource "aws_security_group" "sg_tf_sample" {
  name        = "${var.sg_tf_sample["name"]}"
  description = "${var.sg_tf_sample["name"]}"
  vpc_id      = "${aws_vpc.vpc_tf_sample.id}"

  tags {
    Name = "${var.sg_tf_sample["name"]}"
  }
}

resource "aws_security_group_rule" "tf_sample_egress_all_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg_tf_sample.id}"
}

resource "aws_security_group_rule" "tf_sample_ingress_self_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  self              = true
  security_group_id = "${aws_security_group.sg_tf_sample.id}"
}
