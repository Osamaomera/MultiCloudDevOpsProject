# Jenkins Ansible Role

This Ansible role installs and configures Jenkins on a target server.

## Role Variables

The role allows you to define the following variables to customize the Jenkins installation:

```yaml
---
jenkins_user: 'osama'
jenkins_password: 'osama'
jenkins_fullname: 'osama ayman'
jenkins_email: 'osama.omera680@gmail.com'
jenkins_group: jenkins
jenkins_home: /var/lib/jenkins
jenkins_url: http://pkg.jenkins.io/debian-stable/jenkins.io.key
jenkins_repo: deb http://pkg.jenkins.io/debian-stable binary/
```

## Tasks

Below are the tasks included in this role:

1. **Add Jenkins user and group**: Creates a new user and group named `jenkins`.

2. **Add Jenkins repository key**: Adds the Jenkins repository key for package verification.

3. **Add Jenkins repository**: Adds the Jenkins repository to the package manager.

4. **Update package list**: Updates the package list on the server.

5. **Install Jenkins**: Installs Jenkins on the server.

6. **Ensure Jenkins is started and enabled**: Starts the Jenkins service and ensures it is enabled to start on boot.

7. **Configure Jenkins user**: Sets the Jenkins admin user details.

## Usage

To use this role, include it in your playbook as shown below:

```yaml
- hosts: all
  roles:
    - role: jenkins
```

## Tasks Definition

Here is the detailed definition of each task in the `main.yml` file:

```yaml
---
---
#________________________ Update apt package ________________________#
- name: Update apt cache 
  apt:
    update_cache: yes
  become: true

#________________________ Jenkins installation ________________________#
- name: Ensure the jenkins apt repository key is installed
  apt_key: url=https://pkg.jenkins.io/debian/jenkins.io-2023.key state=present

- name: Ensure the repository is configured
  apt_repository:
    repo: 'deb https://pkg.jenkins.io/debian-stable binary/' 
    state: present

- name: Ensure jenkins is installed
  apt: 
    name: jenkins 
    update_cache: yes
  become: true

#_________________ Configure Jenkins Initial password _________________#
- name: Add Jenkins password
  shell: cat /var/lib/jenkins/secrets/initialAdminPassword
  register: jenkins_initial_password

- name: Create CRUMB authentication request
  uri:
    url: 'http://{{ ansible_host }}:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'
    user: admin
    password: '{{ jenkins_initial_password.stdout }}'
    force_basic_auth: yes
    return_content: yes
  register: crumb

#_____________________ Configure Jenkins admin User ____________________#
- name: Add Jenkins administration account
  uri:
    method: POST
    url: "http://{{ ansible_host }}:8080/securityRealm/createAccountByAdmin"
    user: admin
    password: '{{ jenkins_initial_password.stdout }}'
    force_basic_auth: yes
    follow_redirects: all
    headers:
      Jenkins-Crumb: '{{ crumb.content.split(":")[1] }}'
      Cookie: '{{ crumb.set_cookie }}'
    body: 'username={{ jenkins_user }}&password1={{ jenkins_password }}&password2={{ jenkins_password }}&fullname={{ jenkins_fullname }}&email={{ jenkins_email }}'       
    
#_______________________ Install Jenkins Plugins ________________________#
- name: Install necessary jenkins plugins
  community.general.jenkins_plugin:
    name: "{{ item }}"
    url_username: "{{ jenkins_user }}"
    url_password: "{{ jenkins_password }}"
    url: http://{{ ansible_host }}:8080
    state: latest
  with_items:
    - workflow-aggregator
    - Credentials
    - credentials-binding
    - pipeline
    - github-branch-source
    - pipeline-build-step
    - pipeline-stage-step
    - pipeline-stage-view
    - stage-view
    - pipeline-utility-steps
    - Basic Steps
    - Groovy
    - Stage Step
    - CM Step
    - workflow-cps-global-lib
    - workflow-cps-global-lib
    - shared-groovy-libraries
    - pipeline-github-lib
    - SCM API 
    - Git client
    - Git
    - GitHub API
    - GitHub
    - github-branch-source
    - Docker
    - github-branch-source
    - sonar
    - kubernetes
    - kubernetes-cli

#______________________________ start Jenkins ______________________________#
- name: Skip initial setup
  lineinfile:
    path: /lib/systemd/system/jenkins.service
    regexp: '^Environment="JAVA_OPTS=*'
    line: |
      Environment="JAVA_OPTS=-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"
      Environment="JAVA_ARGS=-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"
      
- name: DAEMON_Realod
  systemd:
    daemon_reload: true

- name: Restart Jenkins service
  service:
    name: jenkins
    state: restarted
    enabled: yes
```

## Author

This role was created by Osama Ayman. If you have any issues or questions, please feel free to reach out at [osama.omera68@gmail.com](mailto:osama.omera68@gmail.com).
