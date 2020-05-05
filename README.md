# CALVIn

# Note: under development. Here be dragons.

## CentOS Amazon Lightsail Virtualmin Installer

This script is designed to be run on a fresh installation of CentOS 7 running on the AWS Lightsail platform. It has been tested on the 512MB and above platforms.

It will install all required dependencies for the following: 

* Virtualmin LAMP
* PHP 7.2 (via Virtualmin) and 7.4 (via Remi)
* NodeJS 12.x LTS
* MariaDB 10.4


It will also change various config file settings and add the key provided to the authorised_keys file for the default centos account.

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
sudo ./launch.sh \
--domain "example.domain.com" \
--pubkey "ssh-ed25520 yourkeygoeshere" \
--virtualmin-user root \
--virtualmin-password "yourPassword1" \
--mysql-password "yourPassword3" \
--webmin-password "yourPassword2" \
--aws-access-key "EXAMPLEACCESSKEY" \
--aws-secret-key "EXAMPLESECRETKEY"
```


### Post-install

An installation log is created in the directory it was run from in `calvin.log`. There is also `calvin.ssl.log` which contains the output of the LetsEncrypt request.

Assuming the installation completed succeffully you should be able to log into the Virtualmin admin panel at the address shown in your terminal.

Some thing to do after logging in:

* Reboot the system!
* Visit the defualt domain (if used) and check the status page is working
* Enable 2FA for the Virtualmin Panel by running `enable-2fa.sh` and then ebaling it under *Webmin -> Webmin Users -> Two-Factor Authentication*
* Enable bandidth monitoring under *Virtualmin -> System Settings -> Bandwidth Monitoring*. You'll also need to setup a reasonable quota as the default is unlimited
* Enable mail client auto-configuration under Virtualmin -> Email Settings -> Mail Client Configuration
* Enable DKIM under Virtualmin -> Email Settings -> DomainKeys Identified Mail
* Set a nice login background under Webmin -> Webmin Configuration -> Webmin Themes -> Theme Backgrounds

	
