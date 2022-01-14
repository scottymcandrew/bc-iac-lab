# Create a new load balancer
resource "aws_elb" "weblb" {
  name = "weblb-terraform-elb"

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  subnets                     = [aws_subnet.web_subnet.id]
  security_groups             = [aws_security_group.web-node.id]
  instances                   = [aws_instance.web_host.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = merge({
    Name = "foobar-terraform-elb"
    }, {
    git_commit           = "4608512ed820e97aa06a17cbe21fadefd6db6cf0"
    git_file             = "aws/elb.tf"
    git_last_modified_at = "2022-01-13 10:22:53"
    git_last_modified_by = "smcandrew@Scotts-MacBook-Pro.local"
    git_modifiers        = "smcandrew"
    git_org              = "scottymcandrew"
    git_repo             = "bc-iac-lab"
    yor_trace            = "b4a83ce9-9a45-43b4-b6d9-1783c282f702"
  })
}