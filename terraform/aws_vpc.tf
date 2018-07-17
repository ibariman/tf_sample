resource "aws_vpc" "vpc_tf_sample" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "vpc_tf_sample"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc_tf_sample.id}"
  count             = "2"
  cidr_block        = "${lookup(var.subnets, count.index)}"
  availability_zone = "${lookup(var.availability_zones, count.index)}"

  tags {
    Name = "tf_sample_${lookup(var.availability_zones, count.index)}"
  }
}
