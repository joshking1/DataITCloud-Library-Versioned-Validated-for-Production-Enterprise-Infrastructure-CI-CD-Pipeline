output "jenkins_ip_address" {
  value = aws_spot_instance_request.jenkins_instance.public_ip
}
