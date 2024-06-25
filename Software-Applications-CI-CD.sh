#!/bin/bash
sudo yum update

sudo yum upgrade -y

sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2

sudo cat /etc/system-release

sudo yum install -y httpd mariadb-server

sudo systemctl start httpd

sudo systemctl enable httpd

sudo systemctl is-enabled httpd

echo "Install Java JDK 11"
sudo yum remove -y java
sudo amazon-linux-extras install java-openjdk11

echo "Install Maven" 

echo "Install git"
yum install git -y

amazon-linux-extras install epel
yum update -y
yum install ansible -y
yum install nginx -y
yum install python-pip -y  
yum install awscli 
yum install boto -y 
cd /home 
touch hug.yml 
touch nat.yml 

echo " Install Terraform"
sudo yum install update -y 
sudo wget https://releases.hashicorp.com/terraform/1.1.2/terraform_1.1.2_linux_amd64.zip 
sudo unzip terraform_1.1.2_linux_amd64.zip
sudo mv terraform /usr/bin/
terraform --version

echo "Install Docker engine"
yum update -y
yum install docker -y
systemctl start docker
systemctl enable docker
systemctl status docker
#sudo usermod -a -G docker jenkins
#sudo service docker start
sudo chkconfig docker on

echo " install Alpine"


echo "Install Jenkins"
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
  
  
docker exec -it myjenkin bash
cat /var/jenkins_home/secrets/initialAdminPassword
exit
docker logs myjenkin
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum install jenkins -y
amazon-linux-extras install epel -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
java -jar jenkins.war\



