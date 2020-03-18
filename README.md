# CALVIn

## CentOS Amazon Lightsail Virtualmin Installer

This script is designed to be run on a fresh installation of CentOS 7 running on the AWS Lightsail platform. It has been tested on the 512MB and above platforms.

It will install all required dependencies for the following: 

* Virtualmin LAMP
* PHP 7.2 (via Virtualmin) and 7.4 (via Remi)
* NodeJS 12.x LTS
* MariaDB 10.4


It will also change various config file settings and add the key provided to
the authorised_keys file for the default centos account.

---

## How to use:

Create your instance and connect via SSH. Use the bash commands provided in the `bootstrap.sh` file to clone the scripts from Git and trigger the installer.

Below is an example useage of the commands from `bootstrap.js`. Note that this is my own public key and you will wish to change it to your own:

```bash
sudo yum install git -y -q
git clone https://github.com/stom66/calvin/ calvin && cd calvin && chmod +x launch.sh

sudo ./launch.sh -d domain.com -k "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEflkUUVLscb4jtD23/WQe0qMwE0cEVvtoO5A8dUz8l7"
```

	
