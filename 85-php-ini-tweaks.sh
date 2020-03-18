#!/bin/bash

#Tweaks various settings for php.ini

virtualmin modify-php-ini --all-domains --ini-name upload_max_filesize --ini-value 32M
virtualmin modify-php-ini --all-domains --ini-name post_max_size  --ini-value 32M

declare PREFIX="Calvin | php-ini-tweaks |"
echo "${PREFIX} upload_max_filesize and post_max_size set to 32M" >> ./calvin.log
