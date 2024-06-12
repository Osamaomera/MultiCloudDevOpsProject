#!/bin/bash

# Script to run Terraform, then update Ansible inventory with EC2 IP, then run Ansible playbook

# Set the paths to Terraform and Ansible directories
terraform_dir="/home/osamaayman/Documents/MultiCloudDevOpsProject/Terraform"
ansible_dir="/home/osamaayman/Documents/MultiCloudDevOpsProject/Ansible"
inventory_file="$ansible_dir/inventory.txt"
private_key_file="/home/osamaayman/test.pem"

# Function to check for necessary tools
check_tools() {
    command -v terraform >/dev/null 2>&1 || { echo "Terraform is required but it's not installed. Aborting."; exit 1; }
    command -v ansible-playbook >/dev/null 2>&1 || { echo "Ansible is required but it's not installed. Aborting."; exit 1; }
}

# Function to run Terraform
run_terraform() {
    cd "$terraform_dir" || { echo "Failed to navigate to Terraform directory. Aborting."; exit 1; }
    echo "Running Terraform in $terraform_dir"
    terraform init
    terraform apply -auto-approve
    echo "Terraform execution completed."
}

# Function to update the Ansible inventory file with the EC2 IP
update_inventory() {
    echo "Updating Ansible inventory file"
    cd "$terraform_dir" || { echo "Failed to navigate to Terraform directory. Aborting."; exit 1; }
    ip_address=$(cat ec2-ip.txt)
    if [ -z "$ip_address" ]; then
        echo "No IP address found in ec2-ip.txt. Aborting."
        exit 1
    fi
    echo -e "jenkins-ec2 ansible_host=${ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=${private_key_file}" > "$inventory_file"
    echo "ansible_host is updated in inventory file."
}

# Function to clean ec2-ip.txt
clean_ec2_ip() {
    cd "$terraform_dir" || { echo "Failed to navigate to Terraform directory. Aborting."; exit 1; }
    echo "" > ec2-ip.txt
}

# Function to run the Ansible playbook
run_ansible() {
    cd "$ansible_dir" || { echo "Failed to navigate to Ansible directory. Aborting."; exit 1; }
    echo "Running Ansible playbook in $ansible_dir"
    export ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -i inventory.txt playbook.yml --ask-vault-pass
    echo "Ansible execution completed."
}

# Main script execution
check_tools
run_terraform
update_inventory
clean_ec2_ip
run_ansible
