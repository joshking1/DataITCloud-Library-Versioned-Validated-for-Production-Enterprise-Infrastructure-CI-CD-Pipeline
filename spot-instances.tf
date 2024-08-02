# Ubuntu Server AMI
data "aws_ami" "ubuntu_server" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Ansible Instance
resource "aws_spot_instance_request" "ansible_instance" {
  ami                         = data.aws_ami.ubuntu_server.id
  instance_type               = "t2.small"
  key_name                    = var.keyname
  spot_price                  = "0.020" # Adjust to a reasonable spot price
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_jenkins.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  user_data                   = file("Software-Applications-CI-CD.sh")
  associate_public_ip_address = true
  tags = {
    Name = "ansible-instance"
  }
}

# Jenkins Instance
resource "aws_spot_instance_request" "jenkins_instance" {
  ami                         = data.aws_ami.ubuntu_server.id
  instance_type               = "t2.medium"
  key_name                    = var.keyname
  spot_price                  = "0.0325" # 70% of the on-demand price
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_jenkins.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "jenkins-instance"
  }
}

# SonarQube Instance
resource "aws_spot_instance_request" "sonarqube_instance" {
  ami                         = data.aws_ami.ubuntu_server.id
  instance_type               = "t2.medium"
  key_name                    = var.keyname
  spot_price                  = "0.0325" # 70% of the on-demand price
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_jenkins.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "sonarqube-instance"
  }
}

# Prometheus Instance
resource "aws_spot_instance_request" "prometheus_instance" {
  ami                         = data.aws_ami.ubuntu_server.id
  instance_type               = "t2.medium"
  key_name                    = var.keyname
  spot_price                  = "0.0325" # 70% of the on-demand price
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_jenkins.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "prometheus-instance"
  }
}

# Grafana Instance
resource "aws_spot_instance_request" "grafana_instance" {
  ami                         = data.aws_ami.ubuntu_server.id
  instance_type               = "t2.medium"
  key_name                    = var.keyname
  spot_price                  = "0.0325" # 70% of the on-demand price
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_jenkins.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "grafana-instance"
  }
}

# Jenkins-Agent-1
resource "aws_spot_instance_request" "jenkins_agent_1" {
  ami                         = data.aws_ami.ubuntu_server.id
  instance_type               = "t2.medium"
  key_name                    = var.keyname
  spot_price                  = "0.0325" # 70% of the on-demand price
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_jenkins.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "jenkins-agent-1"
  }
}

# Security Group for SSH, Jenkins, SonarQube, Prometheus, and Grafana
resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH, Jenkins, SonarQube, Prometheus, and Grafana inbound traffic"
  vpc_id      = aws_vpc.development-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Outputs
output "jenkins_ip_address" {
  value = aws_spot_instance_request.jenkins_instance.public_ip
}

# CloudWatch Metric Alarm
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name                = "ec2_cpu_alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  actions_enabled           = true
  alarm_actions             = []
  insufficient_data_actions = []
  ok_actions                = []

  dimensions = {
    InstanceId = aws_spot_instance_request.jenkins_instance.id
  }
}

# ALB Target Group Attachment
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

# EBS Volume Attachment
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_spot_instance_request.jenkins_instance.id
}
