# Ansible Role: Docker

This Ansible role installs and configures Docker on a target system.

## Requirements

- Supported Operating Systems:
  - Ubuntu

## Role Variables

The following variables can be customized in `vars/main.yml`:

```yaml
---
docker_users:
  - your_username
```

## Dependencies

None.

## Example Playbook

Here is an example of how to use this role in your playbook:

```yaml
---
- name: Install and configure Docker
  hosts: all
  become: yes
  roles:
    - docker
```

## Tasks

This role contains the following tasks, which are defined in `tasks/main.yml`:

1. **Install dependencies:**
   - This task installs required dependencies for Docker.
2. **Add Docker GPG key and repository:**
   - This task adds the Docker GPG key and repository.
3. **Install Docker:**
   - This task installs Docker using the package manager.
4. **Add users to Docker group:**
   - This task adds specified users to the Docker group.
5. **Enable and start Docker service:**
   - This task enables and starts the Docker service.

## Usage

To use this role, add it to your playbook and customize the variables as needed.

## License

MIT

## Author Information

This role was created by Osama Ayman.
```

And the `vars/main.yml` file:

```yaml
---
docker_users:
  - your_username
```

Finally, here's the `tasks/main.yml` for the role:

```yaml
---
#____________________Install dependencies______________________#
- name: Install dependencies
  apt:
    name:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common
    state: present
    update_cache: yes
#________________________ Install Docker ________________________#
- name: Install Docker
  apt:
    name: docker.io
    state: present

#________________ Configure Jenkins to use Docker _______________#
- name: Add jenkins user to docker group
  user:
    name: jenkins
    groups: docker
    append: yes

- name: Change ownership of docker.sock
  file:
    path: /var/run/docker.sock
    owner: root
    group: docker
    state: touch

- name: change docker.sock file permissions
  file:
    path: /var/run/docker.sock
    mode: "0666"

- name: restart jenkins & docker
  service:
    name: '{{ item }}'
    state: restarted
  loop:
        - jenkins
        - docker
```

Make sure to replace `your_username` in `vars/main.yml` with the actual usernames you want to add to the Docker group.