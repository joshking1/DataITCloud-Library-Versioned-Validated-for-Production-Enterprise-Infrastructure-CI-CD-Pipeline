#!/bin/bash

# Update and upgrade the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Apache, MariaDB, and PHP
sudo apt-get install -y apache2 mariadb-server php php-mysql

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Install Java JDK 11
sudo apt-get install -y openjdk-11-jdk

# Install Maven
sudo apt-get install -y maven

# Install Git
sudo apt-get install -y git

# Install Ansible
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install -y ansible

# Install Nginx
sudo apt-get install -y nginx

# Install Python pip
sudo apt-get install -y python3-pip

# Install AWS CLI
sudo apt-get install -y awscli

# Install Boto
pip3 install boto

# Install Terraform
sudo apt-get install -y wget unzip
wget https://releases.hashicorp.com/terraform/1.1.2/terraform_1.1.2_linux_amd64.zip 
unzip terraform_1.1.2_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Install Docker engine
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

# Install Jenkins
sudo docker run \
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

