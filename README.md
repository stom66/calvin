# CALVIn

# Note: under development. Here be dragons.

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

Below is an example useage of the commands from `bootstrap.js`.


#### Launch without parameters:

```bash
sudo yum install git -y -q
git clone https://github.com/stom66/calvin/ calvin && cd calvin && chmod +x launch.sh
sudo ./launch.sh
```

#### Launch with parameters (be sure to set your own key and passwords):

```bash
sudo yum install git -y -q
git clone https://github.com/stom66/calvin/ calvin && cd calvin && chmod +x launch.sh
sudo ./launch --domain domain.com --virtualmin-user root --virtualmin-password mysecretpassword1 --mysql-password mysecretpassword2 --webmin-password mysecretpassword3 --pubkey "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEflkUUVLscb4jtD23/WQe0qMwE0cEVvtoO5A8dUz8l7"
```

	
