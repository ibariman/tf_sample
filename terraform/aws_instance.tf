resource "aws_instance" "web" {
  count                   = 10
  ami                     = "${var.ec2_web["ami"]}"
  instance_type           = "${var.ec2_web["instance_type"]}"
  disable_api_termination = "false"
  key_name                = "${var.ec2_web["key_name"]}"
  subnet_id               = "${element(aws_subnet.private.*.id, count.index%2)}"

  vpc_security_group_ids = [
    "${aws_security_group.sg_tf_sample.id}",
  ]

  tags {
    Name    = "${format("web%02d_tf_sample", count.index + 1)}"
    Segment = "${var.ec2_web["segment"]}"
    Role    = "${var.ec2_web["role"]}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.ec2_web["volume_size"]}"
  }
}
