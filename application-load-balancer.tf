resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_spot_instance_request.jenkins_instance.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_spot_instance_request.jenkins_instance.id
  port             = 80
}
