#!/bin/sh

echo "KICKS == Keep It a Complex Killjoy Script"
echo "Installing Arch Linux to /mnt/arch ..."
echo

### Updating Keyring, installation media is too old!!!
# echo pacman -Sy --noconfirm archlinux-keyring

# Let's assume that the drive is partitioned and ...
# Everything should be mounted on /mnt/arch
# swap should be enabled (if available).

###  Installing desired packages
# base packages
pkgs="base"					# Arch base packages
pkgs="$pkgs sudo"				# Who keeps root account enabled these days???
pkgs="$pkgs btrfs-progs"			# I am a btrfs user :-/
#### pkgs="$pkgs amd-ucode intel-ucode"		# Should I install the damned close source Microcodes???
pkgs="$pkgs grub"				# Obviously we need a boot loader
pkgs="$pkgs efibootmgr"				# We will need efibootmgr if booting via UEFI
pkgs="$pkgs htop"				# How much memory I am using?
pkgs="$pkgs ncdu"				# How much disk space I am using?
pkgs="$pkgs mc"					# Nostalgia :-)
pkgs="$pkgs tmux screen"			# I go both ways (in a good way)
pkgs="$pkgs vim vim-plugins"			# How can we live without vim ???
pkgs="$pkgs screenfetch"			# Showing off
pkgs="$pkgs lshw"				# Tools to list hardware
# Networking / Internet
pkgs="$pkgs openssh"				# We should be able to SSH/SFTP to this PC
pkgs="$pkgs iw wpa_supplicant dhclient"		# Who uses Ethernet these days ???
pkgs="$pkgs lyns links"				# Text based browsers just if needed
pkgs="$pkgs aria2 curl wget"			# Download tools
pkgs="$pkgs mutt"				# Reading emails
# Development
# pkgs="$pkgs arduino"				# Are we doing embedded development?
pkgs="$pkgs git"				# Hello Linus
pkgs="$pkgs base-devel"				# Maybe some development
pkgs="$pkgs qt5"				# Some GUI development
pkgs="$pkgs python"				# Everyone is a parseltongue these days
# GUI
# X Window
#### pkgs="$pkgs xorg xorg-apps"		# Some Graphics plz.
#### pkgs="$pkgs xorg-fonts xorg-drivers"	# Moar Graphiczzz.
# I ain't no i3 user :-P
#### pkgs="$pkgs gnome gnome-extra"		# Gnome???
#### pkgs="$pkgs plasma kde-applications"	# KDE Plasma???
#### pkgs="$pkgs xfce4 xfce4-goodies"		# This is my prefered Desktop Environment
#### pkgs="$pkgs lightdm lightdm-gtk-greeter"	# Display manager for XFCE (and others)

pacstrap /mnt/arch $pkgs

### We need mount points of course.
genfstab -U /mnt/arch >> /mnt/arch/etc/fstab

### chroot to the new installation
echo "chrooting to the new installation"
arch-chroot /mnt/arch

