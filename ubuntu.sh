#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Update package lists
apt-get update

# Upgrade installed packages
apt-get upgrade -y

# Install LAMP stack
apt-get install -y apache2 mariadb-server php libapache2-mod-php

# Start Apache web server
systemctl start apache2

# Enable Apache to start on boot
systemctl enable apache2

# Check if Apache is enabled
systemctl is-enabled apache2

# Install Java JDK 11
apt-get install -y openjdk-11-jdk

# Install Maven
apt-get install -y maven

# Install git
apt-get install -y git

# Install Ansible
apt-get install -y ansible

# Install Nginx
apt-get install -y nginx

# Install Python pip
apt-get install -y python-pip

# Install AWS CLI
apt-get install -y awscli

# Install boto
apt-get install -y python-boto

# Install Terraform
apt-get install -y unzip
wget https://releases.hashicorp.com/terraform/1.1.2/terraform_1.1.2_linux_amd64.zip
unzip terraform_1.1.2_linux_amd64.zip
mv terraform /usr/local/bin/
terraform --version

# Install Docker engine
apt-get install -y docker.io
systemctl start docker
systemctl enable docker

# Install Jenkins using Docker
docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --name jenkins \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/usr/bin/docker \
  -v /home/jenkins_home:/var/jenkins_home \
  jenkins/jenkins

# Check if installation was successful
if [ $? -eq 0 ]; then
  echo "Script executed successfully"
  exit 0
else
  echo "Script encountered an error"
  exit 1
fi
