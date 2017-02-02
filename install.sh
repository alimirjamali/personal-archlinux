#!/bin/sh

echo "KICKS == Keep It a Complex Killjoy Script"
echo "Installing Arch Linux to /mnt ..."
echo

# Updating Keyring, installation media is too old!!!
pacman -Sy --noconfirm archlinux-keyring

# Let's assume that the drive is partitioned and ...
# Everything should be mounted on /mnt
# swap should be enabled (if available).

# Installing desired packages
#	base				Arch base packages
#	grub efibootmgr			Obviously we need boot loaders
#	base-devel			Maybe some development
#	qt5				Some GUI development
#	git				Hello Linus
#	vim vim-plugins			How can we live without vim ???
#	xorg xorg-apps			Some Graphics plz.
#	xorg-fonts xorg-drivers		Moar Graphiczzz.
#	xfce4 xfce4-goodies		I ain't no i3 user :-P
#	lightdm	lightdm-gtk-greeter	We need a display manager
#	iw wpa_supplicant dhclient	Who uses Ethernet these days ???

pacstrap /mnt \
	base			\
	grub efibootmgr		\
	base-devel		\
	qt5			\
	git			\
	vim vim-plugins		\
	xorg xorg-apps		\
	xorg-fonts xorg-drivers	\
	xfce4 xfce4-goodies	\
	lightdm	lightdm-gtk-greeter \
	iw wpa_supplicant dhclient

# We need mount points of course.
genfstab -U /mnt >> /mnt/etc/fstab

# chroot to the new installation
arch-chroot /mnt

# Root password should be obvious!!!
echo "Set root password"
passwd
