#!/bin/sh

echo "KICKS == Keep It a Complex Killjoy Script"
echo "Installing Arch Linux to /mnt/arch ..."
echo

### Updating Keyring, installation media is too old!!!
# echo pacman -Sy --noconfirm archlinux-keyring

# Let's assume that the drive is partitioned and ...
# Everything should be mounted on /mnt/arch
# swap should be enabled (if available).

### Selecting packages for installation
declare -a pkgs=()
# base packages
pkgs+=(base)					# Arch base packages

### Other desired packages
pkgs+=(linux-headers dkms) 		# Linux Headers for Dynamic Kernel Module Support (if needed)
pkgs+=(linux-hardened linux-lts) 	# Alternative Kernels if needed
pkgs+=(sudo)				# Who keeps root account enabled these days???
pkgs+=(pacman-contrib) 			# Pokémon add-ons
pkgs+=(btrfs-progs)			# I am a btrfs user :-/
pkgs+=(compsize)			# ... with online zlib/zstd compression
pkgs+=(ntfs-3g)				# Better NTFS support
pkgs+=(exfat-utils)			# ExFat filesystem support
pkgs+=(f2fs-tools)			# F2FS fielsystem support
pkgs+=(sshfs)				# SFTP based mounts
#! pkgs+=(amd-ucode intel-ucode)	# Should I install the damned close source Microcodes???
pkgs+=(grub grub-customizer)		# Obviously we need a boot loader (and we like to customize it).
#! pkgs+=(grub-btrfs) 			# btrfs snapshots for grub
pkgs+=(os-prober)			# Detecting other OSes for grub
pkgs+=(syslinux) 			# syslinux to chainload HDT (Hardware Detection Tool)
pkgs+=(memtest86+)			# memtest86+ for grub
pkgs+=(efibootmgr)			# We will need efibootmgr if booting via UEFI
pkgs+=(htop)				# How much memory I am using?
pkgs+=(iotop)				# Why the storage is so damn slow??
pkgs+=(glances)				# Sexy tool to monitor system resources
pkgs+=(ncdu)				# How much disk space I am using?
pkgs+=(mc)				# Nostalgia :-)
pkgs+=(tmux screen)			# I go both ways (in a good way)
pkgs+=(vim vim-plugins)			# How can we live without vim ???
pkgs+=(screenfetch)			# Showing off
pkgs+=(lshw)				# Tools to list hardware
pkgs+=(fwupd)				# To upgrade firmware (has anyone over used this? :-o)
pkgs+=(lsof)				# No only list of open files, but also list of open ports.
pkgs+=(unzip)				# This is not to unzip a partner ;-)
pkgs+=(snapper snap-sync snap-pac)	# openSUSE snapper tools
pkgs+=(mlocate)				# Where the hell are my files???
pkgs+=(zip unzip)			# But why not gzip?
pkgs+=(cups cups-pdf)			# I hate printers and PDF files :-/
pkgs+=(arch-install-scripts) 		# If I ever want to install to external media (or update fstab)
pkgs+=(hdparm sdparm smartmontools)	# Utilities to manage spinning rust and NAND
# Networking / Internet
pkgs+=(NetworkManager)			# We need a NetworkManager (do not forget to enable the service)
pkgs+=(traceroute) 			# Where am i going to?
pkgs+=(openssh)				# We should be able to SSH/SFTP to this PC
pkgs+=(iw wpa_supplicant dhclient)	# Who uses Ethernet these days ???
pkgs+=(lynx links)			# Text based browsers just if needed
pkgs+=(aria2 curl wget)			# Download tools
pkgs+=(mutt)				# Reading emails
pkgs+=(iftop nethogs nload)		# Network usage monitoring tools
pkgs+=(dnscrypt-proxy)			# We are anonymous!
pkgs+=(tor nyx torify polipo)		# Really anonymous!!! Warning!!!: Disable polipo's cache
pkgs+=(dnsutils)			# Whois who?
pkgs+=(speedtest-cli)			# How fast we are going?
pkgs+=(vnstat) 				# ... and how much data i have consumed !?
pkgs+=(ethtools)			# I love wired connections :-D
pkgs+=(gnu-netcat)			# Listening to network packets
pkgs+=(ntp)				# What time it is?
pkgs+=(samba)				# Sharing files with poor Wandozee users
#! pkgs+=(openvpn)			# Will be deleted in favor of Wireguard
### Development
#! pkgs+=(arduino)			# Are we doing embedded development?
#! pkgs+=(kicad)			# ... or EDA?
pkgs+=(git)				# Hello Linus
pkgs+=(base-devel)			# Maybe some development
pkgs+=(python)				# Everyone is a parseltongue these days
pkgs+=(go go-tools gcc-go)		# Some packages need golang to compile (but why am I installing the GCC variant?)
pkgs+=(rust)				# Cool kids code with rust these days
pkgs+=(qt5)				# Some GUI development
pkgs+=(emscripten) 			# WebAssembly
#! pkgs+=(atom)				# But why not vim? Why? Why? Why?
#! pkgs+=(fpc fpc-src lazarus qt5pas)	# Free Pascal for nostalgic people
### GUI
# X Window
pkgs+=(xorg xorg-apps)			# Some Graphics plz.
pkgs+=(xorg-fonts xorg-drivers)		# Moar Graphiczzz.
# I ain't no i3 user :-P
pkgs+=(plasma kde-applications)		# KDE Plasma???
#! pkgs+=(gnome gnome-extra)		# Gnome???
#! pkgs+=(xfce4 xfce4-goodies)		# This is my prefered Desktop Environment
#! pkgs+=(lightdm lightdm-gtk-greeter)	# Display manager for XFCE (and others)
# GUI applications from here #
pkgs+=(audacity)			# I can talk
pkgs+=(vlc)				# We need the traffic cone :-)
pkgs+=(obs-studio)			# Screen recodering
pkgs+=(openshot)			# Isn't Kdenlive good enough?
pkgs+=(simplescreenrecorder)		# Moar screen recording :-P
pkgs+=(handbrake handbrake-cli)		# To transcode screen recordings
pkgs+=(firefox)				# We need firefox browser
pkgs+=(chromium)			# ... and chromium!!! 
pkgs+=(libreoffice-fresh)		# Tools used once a week
pkgs+=(krita)				# To draw manga
pkgs+=(gimp)				# Does anyone use this?
pkgs+=(keepassxc)			# Who needs online password managers?
pkgs+=(workrave redshift)		# To protect my health (also consider plasma5-applets-redshift-control if using KDE Plasma)
pkgs+=(gsmartcontrol)			# Getting S.M.A.R.Ter
# Virtualization tools
pkgs+=(libvirt virt-manager bridge-utils) 	# In case we need VMs (enable libvirtd)
pkgs+=(qemu) 				# In case we require to emulate other archituctures
pkgs+=(dosbox)				# I only play old school games :-P

pacstrap /mnt/arch "${pkgs[@]}"

### We need mount points of course.
genfstab -U /mnt/arch >> /mnt/arch/etc/fstab

### chroot to the new installation
echo "chrooting to the new installation"
arch-chroot /mnt/arch

