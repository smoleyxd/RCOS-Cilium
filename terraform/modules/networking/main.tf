resource "aws_elb" "k8s_elb" {
  name               = "${var.cluster_name}-elb"
  availability_zones = var.availability_zones
  subnets            = var.subnets

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.cluster_name}-elb"
  }
}

resource "aws_route53_record" "k8s_dns" {
  zone_id = var.route53_zone_id
  name    = "${var.cluster_name}.${var.route53_zone_name}"
  type    = "A"
  alias {
    name                   = aws_elb.k8s_elb.dns_name
    zone_id                = aws_elb.k8s_elb.zone_id
    evaluate_target_health = true
  }
}
