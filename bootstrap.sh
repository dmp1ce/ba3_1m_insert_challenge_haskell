#!/bin/bash

# Use an updated mirrorlist (use commands below to regenerate)
#pacman -S --needed --noconfirm reflector
#reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
echo "Updating mirrorlist"
test -f /etc/pacman.d/mirrorlist.backup || (echo "Backing up original mirrorlist" && cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup)
cp /vagrant/mirrorlist /etc/pacman.d/mirrorlist

# Update pacman
echo "Updating Arch"
pacman -Syu --noconfirm

# Install php and mysql
echo "Trying to install Haskell and MySQL"
pacman -S --needed --noconfirm mariadb ghc cabal-install

echo "Trying to start MySQL"
systemctl enable mysqld.service
systemctl start mysqld.service

echo "Trying to create MySQL database"
cat /vagrant/create_db.sql | mysql -u root
