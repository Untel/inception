#!/bin/sh
install_dir="/var/www"

if [ ! -f "$install_dir/static/index.html" ]; then
    echo 'Install static website'
    git clone https://github.com/untel/untel.github.io /var/www/static
else
    echo 'Website already installed'
fi