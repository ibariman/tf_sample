variable "alb_web" {
  type = "map"

  default = {
    name         = "web-tf-sample"
    role         = "internal"
    segment      = "private"
    idle_timeout = 1790
  }
}

variable "alb_listener_http" {
  type = "map"

  default = {
    protocol = "HTTP"
    port     = "80"
  }
}

variable "target_group_web" {
  type = "map"

  default = {
    name                 = "web-tf-sample"
    protocol             = "HTTP"
    port                 = "80"
    deregistration_delay = 300
    path                 = "/"
    healthy_threshold    = 3
    unhealthy_threshold  = 3
    timeout              = 4
    interval             = 5
    cookie_duration      = 86400
    segment              = "private"
    role                 = "web"
  }
}
