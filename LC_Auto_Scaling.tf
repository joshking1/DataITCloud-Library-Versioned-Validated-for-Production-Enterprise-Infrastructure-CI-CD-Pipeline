resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "as_conf" {
  name                 = "new-terraform-asg-example-2"
  subnet_ids           = ["Production-Enteprise-Development-Private-Subnet-2", "Production-Enteprise-Development-Private-Subnet-3"]  # Replace with your subnet IDs
  availability_zones   = ["us-east-2a", "us-east-2b"]  # Replace with your desired availability zones
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 2

  lifecycle {
    create_before_destroy = true
  }
}


