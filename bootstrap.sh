# This script is designed to be copy-pasted over SSH and give you a simple way to 
# clone the various scripts and trigger the installer

sudo yum install wget git -y -q
git clone https://github.com/stom66/code-golf/ git-tmp
mkdir lightsail
mv git-tmp/centos/lightsail/* ./lightsail && rm -rf git-tmp
chmod +x lightsail/test.sh && cd lightsail
sudo ./test.sh -d domain.com -k "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEflkUUVLscb4jtD23/WQe0qMwE0cEVvtoO5A8dUz8l7"