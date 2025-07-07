#!/bin/bash

# Update the system
echo "Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

# Install Java 21 (required for Jenkins and Maven)
echo "☕ Installing Java 21..."
sudo apt install -y openjdk-21-jdk

# Ensure Java 21 is set as default
echo "🔧 Setting Java 21 as default..."
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-21-openjdk-amd64/bin/java 1
sudo update-alternatives --set java /usr/lib/jvm/java-21-openjdk-amd64/bin/java

# Verify Java version
echo "Verifying Java version..."
java --version

# Install Jenkins
echo "Adding Jenkins repo and installing Jenkins..."
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

# Enable and start Jenkins
echo "🚀 Enabling and starting Jenkins..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# Install Ansible
echo "🔧 Installing Ansible..."
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update -y
sudo apt install -y ansible

# Install Maven
echo "📦 Installing Maven..."
sudo apt install -y maven

# Final version checks
echo "🧪 Final version check..."
echo "Java version:"
java --version

echo "Jenkins version:"
jenkins --version

echo "Ansible version:"
ansible --version

echo "Maven version:"
mvn --version

echo "✅ All tools installed successfully!"
