#!/bin/bash

echo "Installing Arch Linux to /mnt/arch ..."
echo

### Updating Keyring, installation media is too old!!!
# echo pacman -Sy --noconfirm archlinux-keyring

# Let's assume that the drive is partitioned and all are mounted on the 
# directory provided as argument or /mnt/arch

if [ -z "$1" ]
	then
		install_target="/mnt/arch"
	else
		install_target=$1
fi
if [ ! -d $install_target ]
	then
		echo "Target installation directory does not exist!. Either "\
			"mount target partitions on /mnt/arch or provide the "\
			"target installation directory as an argument."
		exit 1
fi

echo "Swap should be enabled (if available)."

### Selecting packages for installation
declare -a pkgs=()
# base packages
pkgs+=(base)				# Arch base packages

### Other desired packages
pkgs+=(linux-headers dkms) 		# Linux Headers for dkms (if needed)
pkgs+=(linux linux-hardened linux-lts) 	# Kernel & alternative Kernels if needed
pkgs+=(linux-firmware)			# Kernel Firmware of devices
pkgs+=(mkinitcpio dracut booster)	# initramfs generators
pkgs+=(man-db)				# Offline manuals
pkgs+=(sudo opendoas)			# Root account should be disabled later
pkgs+=(bash-completion)                 # Bash completion
pkgs+=(seahorse)                        # Easier management of credentials
pkgs+=(pacman-contrib) 			# Pacman add-ons
pkgs+=(btrfs-progs)			# I am a loyal BTRFS user
pkgs+=(compsize)			# ... with online zlib/zstd compression
# pkgs+=(grub-btrfs) 			# btrfs snapshots for grub
# pkgs+=(snapper snap-sync snap-pac)	# openSUSE snapper tools
pkgs+=(ntfs-3g)				# Better NTFS support
pkgs+=(exfat-utils)			# ExFat filesystem support
pkgs+=(f2fs-tools)			# F2FS fielsystem support
pkgs+=(sshfs)				# SFTP based mounts
pkgs+=(amd-ucode intel-ucode)		# Closed source Microcodes if needed
pkgs+=(grub grub-customizer)		# Boot loader and customizer
pkgs+=(plymouth)			# Fancy boot splash
pkgs+=(os-prober)			# Detecting other OSes for grub
pkgs+=(syslinux) 			# syslinux to chain-load HDT (Hardware Detection Tool)
pkgs+=(memtest86+)			# memtest86+ for grub
pkgs+=(efibootmgr)			# efibootmgr if booting via UEFI
pkgs+=(htop)				# Monitoring resources and processes
pkgs+=(iotop)				# Monitoring storage
pkgs+=(glances)				# Nice tool to monitor system resources
pkgs+=(dmidecode) 			# To see details about RAM modules
pkgs+=(i2c-tools) 			# I2C tools to see FAN RPM
pkgs+=(ncdu duf)			# How much disk space I am using?
pkgs+=(mc)				# Nostalgia :-)
pkgs+=(tmux screen)			# Screen multiplexers
pkgs+=(vim vim-plugins)			# RIP Bram Moolenaar
pkgs+=(screenfetch)			# Showing system config
pkgs+=(lshw)				# Tools to list hardware
pkgs+=(fwupd)				# To upgrade firmware
pkgs+=(lsof)				# List of open files and open ports
pkgs+=(unzip)				# No comment
pkgs+=(unrar) 				# Just in case
pkgs+=(mlocate)				# Where the hell are my files???
pkgs+=(zip unzip)			# But why not gzip?
pkgs+=(p7zip)				# 7-Zip files
pkgs+=(cups cups-pdf)			# Printers and PDF creation
pkgs+=(arch-install-scripts) 		# Easy fstab update or installing on USB
pkgs+=(hdparm sdparm smartmontools)	# To monitor spinning rust and NAND
pkgs+=(ddrescue testdisk)		# Recovery tools (also look at dvdisaster)
# Networking / Internet
pkgs+=(networkmanager)			# We need a NetworkManager (do not forget to enable the service)
pkgs+=(iptables-nft)			# nftables
pkgs+=(traceroute) 			# Tracing packets
pkgs+=(openssh)				# Allowing SSH to this machine
pkgs+=(iw wpa_supplicant dhclient)	# Wireless and DHCP
pkgs+=(lynx links)			# Text based browsers if needed
pkgs+=(aria2 curl wget)			# Download tools
pkgs+=(mutt)				# Reading emails in terminal
pkgs+=(iftop nethogs nload)		# Network usage monitoring tools
pkgs+=(dnscrypt-proxy)			# Encrypting DNS
pkgs+=(tor nyx torsocks torbrowser-launcher)	# Anonymous!!!
pkgs+=(dnsutils)			# Whois who?
pkgs+=(speedtest-cli)			# Measuring Internet speed
pkgs+=(vnstat) 				# Consumed traffic
pkgs+=(ethtool)				# Ethernet tools
pkgs+=(gnu-netcat)			# Listening to network packets
pkgs+=(ntp)				# Time keeping
pkgs+=(samba)				# Sharing files with Windows users
#! pkgs+=(openvpn)			# OpenVPN
### Development
pkgs+=(code)				# VSCode
#! pkgs+=(atom)				# The other Microsoft/Github code editor
pkgs+=(gcc clang llvm)			# Main Compilers
pkgs+=(arduino)				# The Arduino
pkgs+=(kicad)				# EDA
pkgs+=(git)				# Source version control
pkgs+=(base-devel)			# Development tools
pkgs+=(python)				# The latest Python
pkgs+=(go go-tools gcc-go)		# Some packages need golang to compile
pkgs+=(rust)				# Rust
pkgs+=(qt5-base qt6-base qt5-doc qt6-doc)	# Some GUI development
pkgs+=(emscripten) 			# WebAssembly
#! pkgs+=(fpc fpc-src lazarus qt5pas)	# Free Pascal for nostalgic people
### GUI
# X Window
pkgs+=(xorg xorg-apps)			# Should switch to Wayland
pkgs+=(xorg-fonts xorg-drivers)		# Fonts and drivers
#! pkgs+=(plasma kde-applications)	# KDE Plasma???
#! pkgs+=(gnome gnome-extra)		# Gnome???
pkgs+=(xfce4 xfce4-goodies)		# My preferred Desktop Environment
pkgs+=(lightdm lightdm-gtk-greeter)	# Display manager for XFCE (and others)
# GUI applications from here #
pkgs+=(gnu-free-fonts noto-fonts)	# Some fonts
pkgs+=(pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber helvum)
pkgs+=(audacity)			# Working with Audio
pkgs+=(vlc)				# We need the traffic cone :-)
pkgs+=(obs-studio)			# Screen recording and streaming
pkgs+=(kdenlive)			# NLE
pkgs+=(openshot)			# Isn't Kdenlive good enough?
pkgs+=(handbrake handbrake-cli)		# To transcode screen recordings
pkgs+=(firefox)				# We need the Firefox browser
pkgs+=(chromium)			# ... and chromium
pkgs+=(libreoffice-fresh)		# Spreadsheets, Docs and Presentations
pkgs+=(krita)				# Easy to use raster graphics editor
pkgs+=(gimp)				# Not so easy to use graphics editor
pkgs+=(inkscape)			# Vector graphics
pkgs+=(keepassxc)			# My preferred password manager
pkgs+=(workrave redshift)		# To protect my health. Also consider
					# plasma5-applets-redshift-control
					# if using KDE Plasma)
pkgs+=(gsmartcontrol)			# Monitoring S.M.A.R.T status via GUI
# Virtualization tools
pkgs+=(qemu-full)			# In case we require to emulate other archituctures
pkgs+=(libvirt virt-manager) 		# In case we need VMs (enable libvirtd)
pkgs+=(bridge-utils)			# To bridge VMs
pkgs+=(dosbox)				# To play old school games
pkgs+=(yt-dlp)	 			# Downloading Youtube videos
pkgs+=(gparted)				# Partitioning for dummies
pkgs+=(util-linux parted gptfdisk)	# ncurses partitioning

### Installing packages in interactive mode ###
pacstrap -i $install_target "${pkgs[@]}"

### We need mount points of course.
genfstab -U $install_target >> $install_target/etc/fstab

### chroot to the new installation
echo "chrooting to the new installation"
arch-chroot $install_target

