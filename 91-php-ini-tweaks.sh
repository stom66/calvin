#!/bin/bash

#Tweaks various settings for php.ini

virtualmin modify-php-ini --all-domains --ini-name upload_max_filesize --ini-value 32M
virtualmin modify-php-ini --all-domains --ini-name post_max_size  --ini-value 32M

echo "Updated php.ini to allow 32MB uploads" >> ./calvin.log
