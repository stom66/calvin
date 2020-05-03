#!/bin/bash

# Installs the required packages to enable Google Authenticator 2FA for Webmin
declare PREFIX="Calvin | enable-2fa |"

# Copy the CPAN config file

[[ ! -e "/root/.cpan/CPAN" ]] && mkdir -p /root/.cpan/CPAN && echo "${PREFIX} Made CPAN directory" >> ./calvin.log
[[ ! -e "/root/.cpan/CPAN/MyConfig.pm" ]] && cp ./resources/CPAN.pm /root/.cpan/CPAN/MyConfig.pm && chown root /root/.cpan/CPAN/MyConfig.pm && echo "${PREFIX} Copied CPAN config from template" >> ./calvin.log

# Install the right modules
PACKAGES="Archive::Tar Authen::OATH Digest::HMAC Digest::SHA Math::BigInt Moo Moose Module::Build Test::More Test::Needs Type::Tiny Types::Standard"
sudo cpan install $PACKAGES
echo "${PREFIX} Installed perl packages" >> ./calvin.log

# Enable Google Authenticator
echo "twofactor_provider=totp" | sudo tee -a /etc/webmin/miniserv.conf
echo "${PREFIX} Enabled Google Authenticator 2FA for Webmin. You will need to enroll a user manually." >> ./calvin.log


