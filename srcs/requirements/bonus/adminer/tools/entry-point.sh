#!/bin/sh
install_dir="/var/www"

if [ ! -f "$install_dir/adminer/index.php" ]; then
    echo 'Installing Adminer'
    mkdir -p $install_dir/adminer
    cp /tmp/adminer.php $install_dir/adminer/index.php
    echo 'Adminer installed'
else
    echo 'Adminer already installed'
fi