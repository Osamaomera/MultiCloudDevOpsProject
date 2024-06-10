# Ansible Role: Prerequisite Packages

This Ansible role installs and configures prerequisite packages, including the Kubernetes CLI (`kubectl`) and the OpenShift CLI (`oc`), on a target system.

## Requirements

- Supported Operating Systems:
  - Ubuntu

## Role Variables

This role does not require any variables to be customized.

## Dependencies

None.

## Example Playbook

Here is an example of how to use this role in your playbook:

```yaml
---
- name: Install prerequisite packages
  hosts: all
  become: yes
  roles:
    - packages
```

## Tasks

This role contains the following tasks, which are defined in `tasks/main.yml`:

1. **Update and upgrade apt:**
   - This task updates and upgrades the apt package manager.
2. **Install prerequisite packages:**
   - This task installs necessary packages such as wget, curl, and OpenJDK.
3. **Install Kubernetes CLI (`kubectl`):**
   - This task downloads and installs the Kubernetes CLI.
4. **Download, extract, and install OpenShift CLI (`oc`):**
   - This task downloads, extracts, and installs the OpenShift CLI.
5. **Verify OpenShift CLI installation:**
   - This task verifies the installation of the OpenShift CLI and logs the version.

## Usage

To use this role, add it to your playbook as shown above.

## License

MIT

## Author Information

This role was created by Osama Ayman.
```

And the `tasks/main.yml` file:

```yaml
---
#__________________ Install prerequisites packages __________________#
- name: Update and upgrade apt
  apt:
    update_cache: yes
    upgrade: safe

- name: Install prerequisites
  apt:
    name:
      - wget
      - apt-transport-https
      - gnupg2
      - software-properties-common
      - unzip
      - curl
      - tar
      - openjdk-17-jdk
      - openjdk-17-jre
    state: present
    update_cache: yes

- name: Install kubernetes CLI (kubectl)
  become: true
  become_user: root
  shell: |
    curl -LO "https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl"
    mv kubectl /usr/local/bin/
    chmod +x /usr/local/bin/kubectl

- name: Download, extract, and install OpenShift CLI
  shell: |
    wget -O /tmp/openshift-client-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz
    tar -xzvf /tmp/openshift-client-linux.tar.gz -C /tmp/
    mv /tmp/oc /usr/local/bin/
    chmod +x /usr/local/bin/oc
  args:
    creates: /usr/local/bin/oc

- name: Verify OpenShift CLI installation
  shell: oc version
  register: oc_version
  ignore_errors: true

- debug:
    msg: "{{ oc_version.stdout }}"
```
