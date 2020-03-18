#!/bin/bash

# Configures SSHD to force keypair logins, disables root and password logins

sed -i '/^#.*ChallengeResponseAuthentication/s/^#//' /etc/ssh/sshd_config
sed -i '/^ChallengeResponseAuthentication/s/yes/no/' /etc/ssh/sshd_config

sed -i '/^#.*PasswordAuthentication/s/^#//' /etc/ssh/sshd_config
sed -i '/^PasswordAuthentication/s/yes/no/' /etc/ssh/sshd_config

sed -i '/^#.*PermitRootLogin/s/^#//' /etc/ssh/sshd_config
sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config

sed -i '/^#.*UsePAM/s/^#//' /etc/ssh/sshd_config
sed -i '/^UsePAM/s/no/yes/' /etc/ssh/sshd_config