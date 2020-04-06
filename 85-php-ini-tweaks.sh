#!/bin/bash

declare PREFIX="Calvin | php-ini-tweaks |"

# Tweaks various settings for php.ini
virtualmin modify-php-ini --all-domains --ini-name upload_max_filesize --ini-value 32M
virtualmin modify-php-ini --all-domains --ini-name post_max_size  --ini-value 32M

echo "${PREFIX} upload_max_filesize and post_max_size set to 32M" >> ./calvin.log


# Add GNU Terry Pratchett 
sudo tee -a /etc/httpd/conf/httpd.conf > /dev/null <<EOT
#  ╔═╗╔╗╔╦ ╦  ╔╦╗┌─┐┬─┐┬─┐┬ ┬  ╔═╗┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌┬┐┌┬┐
#  ║ ╦║║║║ ║   ║ ├┤ ├┬┘├┬┘└┬┘  ╠═╝├┬┘├─┤ │ │  ├─┤├┤  │  │ 
#  ╚═╝╝╚╝╚═╝   ╩ └─┘┴└─┴└─ ┴   ╩  ┴└─┴ ┴ ┴ └─┘┴ ┴└─┘ ┴  ┴ 
<IfModule headers_module>
  header set X-Clacks-Overhead "GNU Terry Pratchett"
</IfModule>
EOT

echo "${PREFIX} Added GNU Terry Pratchett to httpd.conf" >> ./calvin.log
