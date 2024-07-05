data "aws_ami" "ubuntu_server" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]  # Canonical owner ID
}

# Creating ubuntu server 

resource "aws_instance" "ubuntu-server" {
  ami           = data.aws_ami.ubuntu_server.id
  instance_type = "t2.medium"  # Replace with your desired instance type
  key_name      = "your-key-pair"  # Replace with your key pair name

  tags = {
    Name = "Ubuntu-22.04-Instance"
  }
}

