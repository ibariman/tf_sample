variable "subnets" {
  default = {
    "0" = "10.0.16.0/24"
    "1" = "10.0.17.0/24"
  }
}

variable "availability_zones" {
  default = {
    "0" = "ap-northeast-1a"
    "1" = "ap-northeast-1c"
  }
}
