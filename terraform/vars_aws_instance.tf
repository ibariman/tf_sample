variable "ec2_web" {
  default = {
    instance_type = "t2.nano"
    volume_size   = "50"
    segment       = "private"
    role          = "web"
    ami           = "ami-9c9443e3"
    key_name      = "tf_sample"
  }
}
