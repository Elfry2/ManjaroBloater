#!/bin/bash

packages=(
	https://aur.archlinux.org/epr-git.git
	https://aur.archlinux.org/ttf-ms-fonts.git
	https://aur.archlinux.org/ulauncher.git
	https://aur.archlinux.org/dropbox.git
	https://aur.archlinux.org/spotify.git
	https://aur.archlinux.org/qogir-gtk-theme.git
	https://aur.archlinux.org/kvantum-theme-qogir-git.git
	https://aur.archlinux.org/qogir-icon-theme.git
	https://aur.archlinux.org/nodejs-nativefier.git
	https://aur.archlinux.org/whatsapp-nativefier.git
	https://aur.archlinux.org/museeks-bin.git
)

temporary_storage_directory=elfry_tmp

for i in "${packages[@]}"
do
  sudo rm -r $temporary_storage_directory
  sudo git clone $i $temporary_storage_directory
  sudo chmod 777 $temporary_storage_directory
  cd $temporary_storage_directory
  makepkg -si --noconfirm
  cd ..
  sudo rm -r $temporary_storage_directory
done
