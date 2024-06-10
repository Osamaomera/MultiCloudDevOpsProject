# MultiCloudDevOpsProject

## Roles Overview

This project includes several Ansible roles designed for setting up various components of a DevOps environment across multiple clouds. Each role is structured according to the following directory format:

```
.
├── docker
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
├── Git
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
├── jenkins
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── vars
│   │   └── main.yml
├── packages
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
└── SonarQube
    ├── README.md
    ├── files
    │   └── sonarqube.service
    ├── tasks
    │   └── main.yml
```


## Role Descriptions

- **docker**: Installs Docker and manages Docker containers.
- **Git**: Sets up Git repositories and manages version control.
- **jenkins**: Configures Jenkins CI/CD pipelines.
- **packages**: Installs prerequisite packages and tools.
- **SonarQube**: Installs and configures SonarQube for code analysis.

Refer to each role's README.md file for detailed instructions and usage guidelines.

