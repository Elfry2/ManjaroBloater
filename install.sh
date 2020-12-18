#!/bin/bash
# Title: Manjaro Bloater
# Author: Elfry <elfry.dev28@gmail.com>
# Last Edited: 20201218

# Optimised for Manjaro 20.2 GNOME Edition

# Variables
pacman_packages_remove_tasks_enabled=true
pacman_packages_install_tasks_enabled=true
flatpak_repositories_install_tasks_enabled=true
flatpak_packages_install_tasks_enabled=true
#snap_packages_install_tasks_enabled=true
aur_packages_install_tasks_enabled=true
public_keys_install_tasks_enabled=true
#grub_theme_install_task_enabled=true
nonfree_drivers_install_task_enabled=true
wallpaper_download_task_enabled=true
wallpaper_storage_directory=/usr/share/backgrounds
wallpaper_remote_location=https://cdn.suwalls.com/wallpapers/nature/snowy-rocky-mountains-36084-1920x1200.jpg
temporary_storage_directory=~/Downloads/elfry_tmp

pacman_packages_to_remove=(
	libreoffice
	libreoffice-still
)

pacman_packages_to_install=(
	base-devel
	net-tools
	git
	vim
	ranger
	celluloid
	neofetch
	htop
	gnome-disks
	gnome-disk-utility
	gnome-system-monitor
	libreoffice-fresh
	libindicator-gtk3
	nodejs
	atril
	yay
	flatpak
#	snapd
	preload
	transmission-gtk
	uget
	warpinator
#	kdeconnect
	gtk-engine-murrine
	gtk-engines
	matcha-gtk-theme
	papirus-icon-theme
	winetricks
	gnome-shell-extension-gsconnect
#	kde-gtk-config
)

flatpak_repositories_to_install=(
	flathub\ https://flathub.org/repo/flathub.flatpakrepo
)

flatpak_packages_to_install=(
	flathub\ com.github.tchx84.Flatseal
	flathub\ org.telegram.desktop
	flathub\ com.spotify.Client
)

snap_packages_to_install=(
	whatsdesk
)

aur_packages_to_install=(
	https://aur.archlinux.org/ttf-ms-fonts.git
	https://aur.archlinux.org/ulauncher.git
	https://aur.archlinux.org/dropbox.git
	https://aur.archlinux.org/qogir-gtk-theme.git
	https://aur.archlinux.org/kvantum-theme-qogir-git.git
	https://aur.archlinux.org/qogir-icon-theme.git
)

public_keys_to_install=(
	https://linux.dropbox.com/fedora/rpm-public-key.asc
	https://download.spotify.com/debian/pubkey.gpg
)

#----------------------------------------------------------------------

# Pacman packages installation
if [ "$pacman_packages_remove_tasks_enabled" = true ]; then
	for i in ${pacman_packages_to_remove[*]}
	do sudo pacman -R $i --noconfirm;
	done
	sudo pacman -Rns $(pacman -Qtdq) --noconfirm
	sudo pacman -Scc --noconfirm
fi

if [ "$pacman_packages_install_tasks_enabled" = true ]; then
	sudo pacman -Sy --noconfirm
	sudo pacman-mirrors --fasttrack
	sudo pacman -Syyu --noconfirm
	for i in ${pacman_packages_to_install[*]}
	do sudo pacman -S $i --noconfirm --needed;
	done
	sudo pacman -Syyu --noconfirm
	sudo pacman -Rns $(pacman -Qtdq) --noconfirm
	sudo pacman -Scc --noconfirm
fi

# Public keys installation
if [ "$public_keys_install_tasks_enabled" = true ]; then
	for i in ${public_keys_to_install[*]}
	do 
		sudo rm -r $temporary_storage_directory
		sudo mkdir $temporary_storage_directory
		sudo chmod 777 $temporary_storage_directory
		cd $temporary_storage_directory
		sudo curl -o public-key $i
		gpg --import public-key
		cd ..
	done
fi

# Flatpak repositories installation
if [ "$flatpak_repositories_install_tasks_enabled" = true ]; then
	for ((i = 0; i < ${#flatpak_repositories_to_install[@]}; i++))
	do sudo flatpak remote-add --if-not-exists ${flatpak_repositories_to_install[i]}
	done
	sudo flatpak update -y
fi

# Flatpak packages installation
if [ "$flatpak_packages_install_tasks_enabled" = true ]; then
	sudo flatpak update -y
	for ((i = 0; i < ${#flatpak_packages_to_install[@]}; i++))
	do sudo flatpak install -y ${flatpak_packages_to_install[i]}
	done
	sudo flatpak update -y
fi

# Snap packages installation
if [ "$snap_packages_install_tasks_enabled" = true ]; then
	sudo systemctl enable --now snapd.socket
	for i in ${snap_packages_to_install[*]}
	do sudo snap install $i
	done
fi

# AUR packages installation
if [ "$aur_packages_install_tasks_enabled" = true ]; then
	for i in ${aur_packages_to_install[*]}
	do 
		sudo rm -r $temporary_storage_directory
		sudo git clone $i $temporary_storage_directory
		sudo chmod 777 $temporary_storage_directory
		cd $temporary_storage_directory
		makepkg -si --noconfirm
		cd ..
	done
fi
sudo rm -r $temporary_storage_directory

# Non-free drivers installation
if [ "$nonfree_drivers_install_task_enabled" = true ]; then
	sudo pacman -Syyu --noconfirm
	sudo mhwd -a pci nonfree 0300
fi

# Wallpaper download
if [ "$wallpaper_download_task_enabled" = true ]; then
	(cd $wallpaper_storage_directory && sudo curl -O $wallpaper_remote_location)
fi

# GRUB theme installation
if [ "$grub_theme_install_task_enabled" = true ]; then
	sudo rm -r $temporary_storage_directory
	sudo git clone https://github.com/vinceliuice/grub2-themes.git $temporary_storage_directory
	sudo chmod 777 $temporary_storage_directory
	cd $temporary_storage_directory
	sudo ./install.sh -b -t
	cd ..
fi
sudo rm -r $temporary_storage_directory

echo "Script completed. Please reboot for full effect."
