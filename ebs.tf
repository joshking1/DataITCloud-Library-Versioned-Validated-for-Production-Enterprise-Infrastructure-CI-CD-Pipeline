resource "aws_ebs_volume" "jenkins_instance" {
  availability_zone = "${var.region}a"
  size              = 100
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkins_instance.id
  instance_id = aws_spot_instance_request.jenkins_instance.id
}
