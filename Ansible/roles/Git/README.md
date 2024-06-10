# Ansible Role: Git

This Ansible role installs and configures Git on a target system.

## Requirements

- Supported Operating Systems:
  - Ubuntu

## Role Variables

The following variables can be customized in `vars/main.yml`:

```yaml
# User-specific Git configuration
git_user_name: 'your_name'
git_user_email: 'your_email@example.com'
```

## Dependencies

None.

## Example Playbook

Here is an example of how to use this role in your playbook:

```yaml
---
- name: Install and configure Git
  hosts: all
  become: yes
  roles:
    - git
```

## Tasks

This role contains the following tasks, which are defined in `tasks/main.yml`:

1. **Install Git:**
   - This task installs the Git package using the package manager.
2. **Configure Git User:**
   - This task sets the global Git configuration for user name and email.

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
git_user_name: 'your_name'
git_user_email: 'your_email@example.com'
```

Finally, here's the `tasks/main.yml` for the role:

```yaml
---
# Install Git
- name: Install Git
  apt:
    name: git
    state: present
    update_cache: yes

# Configure Git user
- name: Set Git user name
  git_config:
    name: user.name
    scope: global
    value: "{{ git_user_name }}"
  become: yes
  become_user: "{{ ansible_user }}"

- name: Set Git user email
  git_config:
    name: user.email
    scope: global
    value: "{{ git_user_email }}"
  become: yes
  become_user: "{{ ansible_user }}"
```

Make sure to replace `your_name` and `your_email@example.com` in `vars/main.yml` with your actual Git user name and email.