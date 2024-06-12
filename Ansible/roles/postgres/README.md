Sure, here is a README file tailored for the PostgreSQL role described in your Ansible tasks:

---

# Postgres Role

This role installs and configures PostgreSQL on a target machine, specifically setting up a database and user for SonarQube.

## Requirements

- Ansible 2.9 or higher
- Target machine should be a Debian-based Linux distribution (e.g., Ubuntu)

## Role Variables

This role does not require any additional variables to be set. However, you can customize the following variables if needed:

- `postgresql_user`: The PostgreSQL user to create. Default is `sonarqube`.
- `postgresql_password`: The password for the PostgreSQL user. Default is `pass`.
- `postgresql_db`: The PostgreSQL database to create. Default is `sonarqube`.

You can define these variables in your playbook or in a separate `vars` file.

## Dependencies

This role has no dependencies on other roles.

## Example Playbook

Here's an example of how to use this role in a playbook:

```yaml
- name: Install and configure PostgreSQL for SonarQube
  hosts: servers
  roles:
    - role: postgres
      vars:
        postgresql_user: sonarqube
        postgresql_password: pass
        postgresql_db: sonarqube
```

## Tasks

### Install PostgreSQL

Installs PostgreSQL and the `postgresql-contrib` package:

```yaml
- name: Install postgres
  apt:
    name:
      - postgresql
      - postgresql-contrib
    update_cache: yes
    state: present
```

### Start PostgreSQL Service

Ensures that the PostgreSQL service is enabled and started:

```yaml
- name: Start postgres
  systemd:
    name: postgresql
    enabled: yes
    state: started
```

### Create SonarQube User

Creates a PostgreSQL user for SonarQube:

```yaml
- name: Create SonarQube User
  command: sudo -u postgres psql -c "CREATE USER {{ postgresql_user }} WITH PASSWORD '{{ postgresql_password }}';"
  ignore_errors: yes
```

### Create SonarQube Database

Creates a PostgreSQL database owned by the SonarQube user:

```yaml
- name: Create SonarQube Database
  command: sudo -u postgres psql -c "CREATE DATABASE {{ postgresql_db }} OWNER {{ postgresql_user }};"
  ignore_errors: yes
```

### Grant Privileges to SonarQube User

Grants all privileges on the SonarQube database to the SonarQube user:

```yaml
- name: Grant Privileges to SonarQube User
  command: sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE {{ postgresql_db }} TO {{ postgresql_user }};"
  ignore_errors: yes
```
