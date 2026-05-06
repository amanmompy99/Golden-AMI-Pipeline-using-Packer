# Golden-AMI-Pipeline-using-Packer

This project demonstrates an automated Golden AMI creation pipeline using Jenkins, Packer, Ansible, and AWS EC2.
The objective of the project is to automate the creation of reusable, secure, and standardized Amazon Machine Images (AMIs) that can be used across environments for consistent infrastructure deployments.
Instead of manually configuring EC2 instances, Jenkins triggers an automated Packer build process whenever changes are pushed to GitHub. Packer launches a temporary EC2 build instance and uses Ansible to provision and configure the server before creating the Golden 

