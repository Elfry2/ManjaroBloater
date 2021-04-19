#!/bin/bash

#Scripts to run. To skip a script, simply comment it out.
scripts=(
  rank_mirrors.sh
  update_system.sh
  remove_pacman_packages.sh
  install_pacman_packages.sh
  remove_unused_pacman_packages.sh
  clear_pacman_cache.sh
  install_flatpak_repositories.sh
  install_flatpak_packages.sh
  install_public_keys.sh
  install_aur_packages.sh
  install_wallpapers.sh
)

for i in "${scripts[@]}"
do
  if ! test -f $i; then
    echo "`basename $BASH_SOURCE`: ERROR: Cannot find $i. Exiting..."
    exit
  fi
done

for i in "${scripts[@]}"
do
  source $i
done
