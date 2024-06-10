# SonarQube Ansible Role

This Ansible role installs and configures SonarQube on a target server.

## Role Variables

The role doesn't require any special variables to be defined by the user. However, you can override the default variables if needed.


## Tasks

Below are the tasks included in this role:

1. **Add sonarqube user**: Creates a new user named `sonarqube` with a home directory `/opt/sonarqube`.

2. **Add settings block to sysctl.conf**: Adds necessary kernel parameters to `/etc/sysctl.conf`.

3. **Apply sysctl settings**: Applies the sysctl settings using the `sysctl --system` command.

4. **Download SonarQube zip file**: Downloads the SonarQube zip file from the official URL to the specified destination.

5. **Unzip SonarQube**: Unzips the downloaded SonarQube zip file to the `/opt/` directory and sets the owner to `sonarqube`.

6. **Add settings block to sonar.properties**: Configures SonarQube by adding necessary settings to `sonar.properties`.

7. **Copy SonarQube service file**: Copies the `sonarqube.service` file from the `files` directory to `/etc/systemd/system/`.

8. **Reload Systemd daemon**: Reloads the systemd daemon to recognize the new service file.

9. **Start SonarQube service**: Starts and enables the SonarQube service to run on boot.

## Usage

To use this role, include it in your playbook as shown below:

```yaml
- hosts: all
  roles:
    - role: sonarqube
```

Ensure that the `sonarqube.service` file is present in the `files` directory within the role.

## Example `sonarqube.service` file

The `sonarqube.service` file should be defined as follows:

```ini
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube-9.9.1.69595/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube-9.9.1.69595/bin/linux-x86-64/sonar.sh stop

User=sonarqube
Group=sonarqube
Restart=always
LimitNOFILE=65536
LimitNPROC=4096
TimeoutStartSec=5

[Install]
WantedBy=multi-user.target
```

## Author

This role was created by Osama Ayman. If you have any issues or questions, please feel free to reach out.
