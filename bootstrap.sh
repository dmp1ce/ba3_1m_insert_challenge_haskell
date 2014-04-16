#!/bin/bash

# Use an updated mirrorlist (use commands below to regenerate)
#pacman -S --needed --noconfirm reflector
#reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
echo "Updating mirrorlist"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
cp /vagrant/mirrrorlist /etc/pacman.d/mirrorlist

# Update pacman
echo "Updating Arch"
pacman -Syu --noconfirm

# Install php and mysql
echo "Trying to install PHP and MySQL"
pacman -S --needed --noconfirm php mariadb

echo "Trying to start MySQL"
systemctl enable mysqld.service
systemctl start mysqld.service

echo "Trying to create MySQL database"
