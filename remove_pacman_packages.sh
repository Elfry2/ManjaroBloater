#!/bin/bash

packages=(
#	libreoffice
#	libreoffice-still
)

for i in "${packages[@]}"
do
  sudo pacman -R $i --noconfirm;
done
sudo pacman -Rns $(pacman -Qtdq) --noconfirm
sudo pacman -Scc --noconfirm
