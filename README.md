# MultiCloudDevOpsProject

This project demonstrates a comprehensive DevOps pipeline that integrates Terraform for infrastructure provisioning, Ansible for configuration management, Docker for containerization, Jenkins for continuous integration, and OpenShift for deployment. The pipeline automates the deployment of a sample application to OpenShift, ensuring a streamlined and efficient workflow. Additionally, it integrates monitoring and logging, as well as AWS services.

## Project Archticture 

![alt text](screenshots/final_project.drawio.svg)


## Project Structure
```
├── Ansible
├── app
├── OpenShift
├── screenshots
├── scripts
├── Terraform
├── jenkinsfile
└── README.md
```
## Table of Contents

1. [Project Setup](#project-setup)
2. [Infrastructure Provisioning](#infrastructure-provisioning)
3. [Configuration Management](#configuration-management)
4. [Containerization](#containerization)
5. [Continuous Integration](#continuous-integration)
6. [Automated Deployment Pipeline](#automated-deployment-pipeline)
7. [Monitoring and Logging](#monitoring-and-logging)
8. [AWS Integration](#aws-integration)
9. [Documentation](#documentation)

## Prerequisites
Before using this project, ensure that you have the following prerequisites:

- Docker: For building and managing containerized applications.
- Kubernetes/OpenShift: For orchestrating containerized applications.
- Jenkins: For implementing continuous integration and continuous deployment (CI/CD) pipelines.
- Docker Hub Account: For storing Docker images.
- Git: For version control and cloning the project repository.


## Repository Setup

### Initial Configuration

1. **Create and Clone the Repository:**
   - Create a new repository named "MultiCloudDevOpsProject" on GitHub.
   - Clone the repository to your local machine to get started:
     ```
     git clone https://github.com/Osamaomera/MultiCloudDevOpsProject.git
     ```

2. **Branching:**
   - **Main Branch:** Contains the production-ready code.
   - **Dev Branch:** Used for ongoing development work.
  
3. **Branch Creation:**
   - Create a development branch named `dev` for ongoing changes:
     ```
     git checkout -b dev
     git push origin dev
     ```

By following these steps, you'll have a structured repository for your DevOps project, with separate branches for development and production-ready code.


## Infrastructure Provisioning

The infrastructure for this project is provisioned using Terraform. It includes the following modules:

- EC2 Module
- VPC Module
- Subnet Module
- CloudWatch Module

This setup provisions an EC2 instance to run Jenkins, which will be used for pipeline execution.

For detailed information, refer to the [Terraform README](terraform/README.md).

## Configuration Management

Configuration management is handled by Ansible. The playbooks configure the EC2 instance by installing the required software and setting up necessary environment variables. The roles included are:

- `packages` role for prerequisites like `oc cli`, `jdk`, and `maven`
- `git` role
- `postgres` role for SonarQube
- `sonarqube` role
- `jenkins` role
- `docker` role

For detailed information, refer to the [Ansible README](ansible/README.md).

## Containerization

Containerization plays a crucial role in this project's architecture, facilitating efficient deployment and management of applications. Docker is the primary tool used for containerization. Below are the key components and tasks related to containerization:

- **Dockerfile:**
  - A Dockerfile is provided to build the application image. It includes instructions on how to package the application and its dependencies into a Docker container.

- **Image Repository:**
  - The Docker image is pushed to a container registry, such as Docker Hub or a private registry, for storage and distribution.

- **Container Deployment:**
  - The Docker image is deployed as containers on the target environment, ensuring consistent and isolated execution of the application.


## Configuration Management

Configuration management for this project is orchestrated by Ansible. The playbooks are responsible for configuring the EC2 instance, installing essential software, and setting up crucial environment variables. Below are the roles included in the configuration management process:

- **Packages Role:**
  - Installs prerequisites such as `oc cli`, `jdk`, and `maven` needed for the project.

- **Git Role:**
  - Handles the installation and configuration of Git on the target system.

- **Postgres Role for SonarQube:**
  - Sets up PostgreSQL for SonarQube, including user creation and database setup.

- **SonarQube Role:**
  - Configures SonarQube on the EC2 instance, ensuring it's ready for code analysis.

- **Jenkins Role:**
  - Installs and configures Jenkins on the EC2 instance to facilitate continuous integration and deployment.

- **Docker Role:**
  - Manages the installation and setup of Docker, enabling containerization within the environment.

For a more comprehensive understanding of each role and its tasks, please refer to the [Ansible README](ansible/README.md).

## Automated Deployment Pipeline

### Task
- Deliver Jenkins pipeline configuration in Jenkinsfile with stages:
  - Git Checkout
  - Build
  - Unit Test
  - SonarQube Test
  - Deploy on OpenShift

### Deliverables
- Jenkins pipeline configured in the Jenkinsfile.

## Monitoring and Logging

### Task
- Deliver setup instructions for centralized logging on OpenShift for container logs.

### Deliverables
- Instructions for setting up centralized logging.

## AWS Integration

### Task
- Provide instructions for integrating AWS services:
  - Use S3 Terraform Backend state.
  - Integrate CloudWatch for monitoring.

### Deliverables
- Instructions for AWS integration in the Terraform Code.

## Documentation

### Task
- Deliver comprehensive documentation:
  - Setup instructions.
  - Architecture overview.
  - Troubleshooting guidelines.

### Deliverables
- Documentation is available in the repository.

---

This README provides an overview and serves as a navigation guide for the different components of the project. Each section is linked to the respective detailed documentation for in-depth information.

## Project Structure

1. **Terraform**: Provisioning AWS infrastructure.
2. **Ansible**: Configuring the EC2 instances.
3. **OpenShift**: Deploying the application.
4. **Jenkins**: Managing the CI/CD pipeline.

## Sections

### 1. Infrastructure Provisioning with Terraform

This section involves using Terraform to set up the necessary AWS infrastructure, including VPCs, subnets, EC2 instances, and CloudWatch monitoring.

For detailed information on the Terraform configuration, refer to the [Terraform README](Terraform/README.md).

### 2. Configuration Management with Ansible

Ansible is used to install and configure necessary packages on the EC2 instances provisioned by Terraform.

For detailed information on the Ansible setup, refer to the [Ansible README](Ansible/README.md).

### 3. Application Deployment on OpenShift

This section includes the deployment and service configurations necessary to deploy the application on an OpenShift cluster.

For detailed information on the OpenShift deployment, refer to the [OpenShift README](openshift/README.md).

### 4. Continuous Integration with Jenkins

The Jenkinsfile defines the pipeline stages for building, testing, and deploying the application. It also uses a shared library for reusable functions.

For detailed information on the Jenkins pipeline, refer to the [Jenkins README](jenkins/README.md).




## Infrastructure Provisioning with Terraform
### Task
- Deliver Terraform scripts for AWS resource provisioning:
  - VPC, Subnets, Security Groups.
  - EC2 instances for application deployment.

### Deliverables
- Terraform scripts committed to the repository.
- Use Terraform Modules.

#### Example Terraform Script
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "multi-cloud-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_instances" {
  source          = "./modules/ec2"
  instance_count  = 2
  instance_type   = "t2.micro"
  key_name        = "my-key"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = element(module.vpc.public_subnets, 0)
  security_groups = [module.security_group.this_security_group_id]
}
```

## Configuration Management with Ansible
### Task
- Deliver Ansible playbooks for EC2 instance configuration:
  - Install the required packages (e.g., Git, Docker, Java).
  - Install the required packages for Jenkins.
  - Install the required packages for SonarQube.
  - Set up necessary environment variables.

### Deliverables
- Ansible playbooks committed to the repository.
- Use Ansible roles.

#### Example Ansible Playbook
```yaml
- name: Install packages
  hosts: all
  become: yes
  roles:
    - common
    - jenkins
    - sonarqube

# roles/common/tasks/main.yml
- name: Install basic packages
  apt:
    name:
      - git
      - docker.io
      - openjdk-11-jdk
    state: present

# roles/jenkins/tasks/main.yml
- name: Install Jenkins
  apt:
    name: jenkins
    state: present

# roles/sonarqube/tasks/main.yml
- name: Install SonarQube
  apt:
    name: sonarqube
    state: present
```

## Containerization with Docker
### Task
- Deliver Dockerfile for building the application image.

### Deliverables
- Dockerfile committed to the repository.

#### Example Dockerfile
```dockerfile
FROM openjdk:11-jre-slim
WORKDIR /app
COPY . /app
RUN ./gradlew build
CMD ["java", "-jar", "build/libs/demo.jar"]
```

## Continuous Integration with Jenkins
### Task
- Deliver Jenkins job configuration instructions for building Docker image on code commits.

### Deliverables
- Jenkins job instructions for the configuration.

#### Example Jenkinsfile
```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', credentialsId: 'GitHub', url: 'https://github.com/Osamaomera/MultiCloudDevOpsProject.git'
            }
        }
        stage('Build') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Test') {
            steps {
                sh './gradlew test'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("myapp:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerHubCredentialsID') {
                        docker.image("myapp:${env.BUILD_ID}").push()
                    }
                }
            }
        }
    }
}
```

## Automated Deployment Pipeline
### Task
- Deliver Jenkins pipeline configuration in Jenkinsfile:
  - Stages: Git Checkout, Build, Unit Test, SonarQube Test, Deploy on OpenShift.
  - Use Shared Jenkins Library.

#### Example Jenkinsfile with Shared Library
```groovy
@Library('shared_library')_
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkoutRepo()
            }
        }
        stage('Build') {
            steps {
                runUnitTests()
            }
        }
        stage('SonarQube Analysis') {
            steps {
                runSonarQubeAnalysis()
            }
        }
        stage('Build Docker Image') {
            steps {
                buildDockerImage()
            }
        }
        stage('Push Docker Image') {
            steps {
                pushDockerImage()
            }
        }
        stage('Deploy to OpenShift') {
            steps {
                deployToOpenShift()
            }
        }
    }
}
```

## Monitoring and Logging
### Task
- Deliver setup instructions for centralized logging on OpenShift for container logs.

## Overview

This guide explains how to set up Kubernetes monitoring using Prometheus and Grafana in an EKS cluster using Helm charts. This setup includes Prometheus for collecting and storing metrics data, Alert Manager for sending alerts, and Grafana for visualizing the metrics in a UI.

### Key Components

1. **Prometheus Server:** Processes and stores metrics data.
2. **Alert Manager:** Sends alerts to various systems/channels.
3. **Grafana:** Visualizes scraped data in a user-friendly UI.

### Installation Method

We recommend using Helm charts for a streamlined installation process. Helm is a package manager for Kubernetes that simplifies the deployment of complex systems like Prometheus and Grafana.

### Prerequisites

- EKS Cluster up and running
- Helm3 installed
- EC2 instance to access the EKS cluster

## Implementation Steps

### Add Helm Repositories

```bash
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

### Create Prometheus Namespace

```bash
kubectl create namespace prometheus
```

### Install kube-prometheus-stack

```bash
helm install stable prometheus-community/kube-prometheus-stack -n prometheus
```

Verify the installation:

```bash
kubectl get pods -n prometheus
kubectl get svc -n prometheus
```

### Access Grafana UI

Get the Load Balancer URL:

```bash
kubectl get svc -n prometheus
```

Access Grafana UI in your browser using the Load Balancer URL:

- URL: [Grafana URL]
- Username: admin
- Password: prom-operator

### Create Dashboards in Grafana

1. **Kubernetes Monitoring Dashboard:**
   - Click '+' on the left panel and select ‘Import’.
   - Enter the dashboard ID 12740 from Grafana.com Dashboard.
   - Select ‘Prometheus’ as the data source.
   - Click ‘Import’.

2. **Kubernetes Cluster Monitoring Dashboard:**
   - Click '+' on the left panel and select ‘Import’.
   - Enter the dashboard ID 3119 from Grafana.com Dashboard.
   - Select ‘Prometheus’ as the data source.
   - Click ‘Import’.

3. **POD Monitoring Dashboard:**
   - Click '+' on the left panel and select ‘Import’.
   - Enter the dashboard ID 6417 from Grafana.com Dashboard.
   - Select ‘Prometheus’ as the data source.
   - Click ‘Import’.


### Deliverables
- Instructions for setting up centralized logging.

#### Example Logging Setup Instructions
1. Install EFK (Elasticsearch, Fluentd, Kibana) stack on OpenShift.
2. Configure Fluentd to collect logs from the application containers.
3. Set up Kibana dashboards to visualize the logs.

## AWS Integration
### Task
- Provide instructions for integrating AWS services:
  - Use S3 Terraform Backend state.
  - Integrate CloudWatch for monitoring.

### Deliverables
- Instructions for AWS integration in the Terraform Code.

#### Example AWS Integration Instructions
1. Configure S3 backend in Terraform:
    ```hcl
    terraform {
      backend "s3" {
        bucket = "my-terraform-state"
        key    = "path/to/my/key"
        region = "us-east-1"
      }
    }
    ```
2. Integrate CloudWatch in Terraform:
    ```hcl
    resource "aws_cloudwatch_log_group" "example" {
      name = "example-log-group"
      retention_in_days = 14
    }
    ```

## Documentation
### Task
- Deliver comprehensive documentation:
  - Setup instructions.
  - Architecture overview.
  - Troubleshooting guidelines.

### Deliverables
- Documentation is available in the repository.

#### Example Documentation Sections
1. **Setup Instructions**
    - Clone the repository.
    - Follow the instructions to set up the infrastructure using Terraform.
    - Use Ansible playbooks to configure the EC2 instances.
    - Build and push the Docker image using Jenkins.
    - Deploy the application to OpenShift.

2. **Architecture Overview**
    - Description of the infrastructure components (VPC, subnets, EC2 instances, security groups).
    - Explanation of the CI/CD pipeline stages.
    - Overview of the monitoring and logging setup.

3. **Troubleshooting Guidelines**
    - Common issues and their solutions.
    - Links to relevant documentation and resources.

## Troubleshooting
### Common Issues
- **Disk Space Issues**: Ensure there is sufficient disk space on the Jenkins server.
- **Network Issues**: Verify network connectivity between the Jenkins server and the GitHub repository, Docker registry, and OpenShift cluster.
- **Permission Issues**: Check the permissions and credentials used for accessing AWS, DockerHub, and OpenShift.

### Useful Commands
- **Terraform Commands**:
  - `terraform init`: Initialize the Terraform configuration.
  - `terraform apply`: Apply the Terraform configuration to provision resources.
- **Ansible Commands**:
  - `ansible-playbook -i inventory playbook.yml`: Run an Ansible playbook.
- **Docker Commands**:
  - `docker build -t myapp .`: Build a Docker image.
  - `docker push myapp`: Push a Docker image to the registry.
- **Jenkins Commands**:
 
 ### Refrences 

https://www.coachdevops.com/2022/05/how-to-setup-monitoring-on-kubernetes.html

## Documentation 

| Resource                         | Link                                                                                       |
|----------------------------------|--------------------------------------------------------------------------------------------|
| Ansible Documentation            | [Ansible Documentation](https://docs.ansible.com/)                                         |
| Ansible Galaxy                   | [Ansible Galaxy](https://galaxy.ansible.com/)                                              |
| Jenkins Documentation            | [Jenkins Documentation](https://www.jenkins.io/doc/)                                       |
| Docker Documentation             | [Docker Documentation](https://docs.docker.com/)                                           |
| Terraform Documentation          | [Terraform Documentation](https://www.terraform.io/docs/index.html)                        |
| SonarQube Documentation          | [SonarQube Documentation](https://docs.sonarqube.org/latest/)                               |
| OpenShift CLI Documentation      | [OpenShift CLI Documentation](https://docs.openshift.com/container-platform/latest/cli_reference/openshift_cli/getting-started-cli.html) |
| AWS EC2 Documentation            | [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/index.html)                        |