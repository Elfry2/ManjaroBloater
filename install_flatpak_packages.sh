#!/bin/bash

packages=(
#  flathub\ com.github.tchx84.Flatseal
#  flathub\ org.telegram.desktop
#  flathub\ com.spotify.Client
)

for i in "${packages[@]}"
do
  flatpak install --assumeyes $i
done
