#!/bin/bash

packages=(
	base-devel
	net-tools
	git
	vim
	gedit
	ranger
	celluloid
	neofetch
	htop
	gnome-disks
	gnome-disk-utility
	gnome-system-monitor
	libreoffice-still
#	libreoffice-fresh
	libindicator-gtk3
	nodejs
	atril
	yay
	flatpak
#	snapd
#	preload
	transmission-gtk
	uget
	warpinator
#	kdeconnect
	gtk-engine-murrine
	gtk-engines
	matcha-gtk-theme
	papirus-icon-theme
	wine
	gnome-shell-extension-gsconnect
#	kde-gtk-config
	brave
	webapp-manager
	telegram-desktop
	atom
)

sudo pacman -Sy --noconfirm
for i in "${packages[@]}"
do
  sudo pacman -S $i --noconfirm --needed
done
