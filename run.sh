#!/bin/bash

#script to run terraform, then update ansible inventory with EC2 IP, then run ansible playbook

#Set the paths to Terraform and Ansible directories
terraform_dir="/home/osamaayman/deploy_app_on_aws_eks/Terraform"
ansible_dir="/home/osamaayman/deploy_app_on_aws_eks/Ansible"

#run terraform
terraform() {
    cd "$terraform_dir"
    echo "Running Terraform in $terraform_dir"
    terraform init
    terraform apply -auto-approve
    echo "Terraform execution completed."
 }

#update the ansible_host value in inventory.txt with EC2 IP 
update_inventory() {
    echo "Updating Ansible inventory file"
    cd "$terraform_dir"
    ip_address=$(cat "$terraform_dir/ec2-ip.txt")    
   echo -e "jenkins-ec2 ansible_host=${ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ibrahim/test.pem" > "$ansible_dir/inventory.txt"

    echo "ansible_host is updated in inventory file."
}

#delete EC2 ip form ec2-ip.txt
clean_ec2-ip(){
    cd "$terraform_dir"
    echo "" > "$terraform_dir/ec2-ip.txt"
}

#run Ansible playbook
ansible() {
    cd "$ansible_dir"
    echo "Running Ansible playbook in $ansible_dir"
    export ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -i inventory.txt playbook.yml --ask-valut-pass
    echo "Ansible execution completed."
}

terraform
update_inventory
clean_ec2-ip
ansible