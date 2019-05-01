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
pkgs="$pkgs compsize"				# ... with online zlib/zstd compression
pkgs="$pkgs ntfs-3g"				# Better NTFS support
pkgs="$pkgs exfat-utils"			# ExFat filesystem support
pkgs="$pkgs f2fs-tools"				# F2FS fielsystem support
pkgs="$pkgs sshfs"				# SFTP based mounts
#### pkgs="$pkgs amd-ucode intel-ucode"		# Should I install the damned close source Microcodes???
pkgs="$pkgs grub"				# Obviously we need a boot loader
pkgs="$pkgs os-prober"				# Detecting other OSes for grub
pkgs="$pkgs memtest86+"				# memtest86+ for grub
pkgs="$pkgs efibootmgr"				# We will need efibootmgr if booting via UEFI
pkgs="$pkgs htop"				# How much memory I am using?
pkgs="$pkgs ncdu"				# How much disk space I am using?
pkgs="$pkgs mc"					# Nostalgia :-)
pkgs="$pkgs tmux screen"			# I go both ways (in a good way)
pkgs="$pkgs vim vim-plugins"			# How can we live without vim ???
pkgs="$pkgs screenfetch"			# Showing off
pkgs="$pkgs lshw"				# Tools to list hardware
pkgs="$pkgs fwupd"				# To upgrade firmware (has anyone over used this? :-o)
pkgs="$pkgs lsof"				# No only list of open files, but also list of open ports.
pkgs="$pkgs unzip"				# This is not to unzip a partner ;-)
pkgs="$pkgs snapper snap-sync snap-pac"		# openSUSE snapper tools
pkgs="$pkgs mlocate"				# Where the hell are my files???
pkgs="$pkgs zip unzip"				# But why not gzip?
pkgs="$pkgs cups cups-pdf"			# I hate printers and PDF files :-/
# Networking / Internet
pkgs="$pkgs openssh"				# We should be able to SSH/SFTP to this PC
pkgs="$pkgs iw wpa_supplicant dhclient"		# Who uses Ethernet these days ???
pkgs="$pkgs lynx links"				# Text based browsers just if needed
pkgs="$pkgs aria2 curl wget"			# Download tools
pkgs="$pkgs mutt"				# Reading emails
pkgs="$pkgs iftop nload"			# Network usage monitoring tools
pkgs="$pkgs dnscrypt-proxy"			# We are anonymous!
pkgs="$pkgs tor nyx torify polipo"		# Really anonymous!!!
pkgs="$pkgs dnsutils"				# Whois who?
pkgs="$pkgs speedtest-cli"			# How fast we are going?
pkgs="$pkgs ethtools"				# I love wired connections :-D
pkgs="$pkgs gnu-netcat"				# Listening to network packets
pkgs="$pkgs ntp"				# What time it is?
# pkgs="$pkgs openvpn"				# Will be deleted in favor of Wireguard
# Development
# pkgs="$pkgs arduino"				# Are we doing embedded development?
# pkgs="$pkgs kicad"				# ... or EDA?
pkgs="$pkgs git"				# Hello Linus
pkgs="$pkgs base-devel"				# Maybe some development
pkgs="$pkgs go go-tools gcc-go"			# Some packages need golang to compile (but why am I installing the GCC variant?)
pkgs="$pkgs rust"				# Cool kids code with rust these days
pkgs="$pkgs qt5"				# Some GUI development
# pkgs="$pkgs atom"				# But why not vim? Why? Why? Why?
pkgs="$pkgs python"				# Everyone is a parseltongue these days
# GUI
# X Window
pkgs="$pkgs xorg xorg-apps"			# Some Graphics plz.
pkgs="$pkgs xorg-fonts xorg-drivers"		# Moar Graphiczzz.
# I ain't no i3 user :-P
pkgs="$pkgs plasma kde-applications"	# KDE Plasma???
#### pkgs="$pkgs gnome gnome-extra"		# Gnome???
#### pkgs="$pkgs xfce4 xfce4-goodies"		# This is my prefered Desktop Environment
#### pkgs="$pkgs lightdm lightdm-gtk-greeter"	# Display manager for XFCE (and others)
# GUI applications from here #
pkgs="$pkgs audacity"				# I can talk
pkgs="$pkgs vlc"				# We need the traffic cone :-)
pkgs="$pkgs obs-studio"				# Screen recodering
pkgs="$pkgs openshot"				# Isn't Kdenlive good enough?
pkgs="$pkgs simplescreenrecorder"		# Moar screen recording :-P
pkgs="$pkgs handbrake handbrake-cli"		# To transcode screen recordings
pkgs="$pkgs firefox"				# We need firefox browser
pkgs="$pkgs chromium"				# ... and chromium!!! 
pkgs="$pkgs libreoffice-fresh"			# Tools used once a week
pkgs="$pkgs krita"				# To draw manga
pkgs="$pkgs gimp"				# Does anyone use this?
pkgs="$pkgs keepassxc"				# Who needs online password managers?

pacstrap /mnt/arch $pkgs

### We need mount points of course.
genfstab -U /mnt/arch >> /mnt/arch/etc/fstab

### chroot to the new installation
echo "chrooting to the new installation"
arch-chroot /mnt/arch

