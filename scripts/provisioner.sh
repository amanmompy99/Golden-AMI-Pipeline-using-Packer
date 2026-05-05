#!/usr/bin/env bash
set -euxo pipefail

#############################################
# Update system
#############################################
sudo dnf update -y

##############################################
# Install base tools
# Do not install curl explicitly on AL2023;
# curl-minimal is usually already installed.
#############################################
sudo dnf install -y git wget unzip tar dnf-plugins-core

#############################################
# Install Docker
#############################################
sudo dnf install -y docker

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

#############################################
# Install / enable SSM Agent
#############################################
if ! rpm -q amazon-ssm-agent >/dev/null 2>&1; then
  sudo dnf install -y amazon-ssm-agent || \
  sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
fi

sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

#############################################
# Install CloudWatch Agent
# Start later after providing a config file.
#############################################
sudo dnf install -y amazon-cloudwatch-agent || \
sudo dnf install -y https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm

#############################################
# Basic hardening
#############################################
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

#############################################
# Cleanup
#############################################
sudo dnf clean all