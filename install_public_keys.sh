#!/bin/bash

keys=(
	https://linux.dropbox.com/fedora/rpm-public-key.asc
	https://download.spotify.com/debian/pubkey_0D811D58.gpg
)

temporary_storage_directory=elfry_tmp

for i in "${keys[@]}"
do
  sudo rm -r $temporary_storage_directory
  sudo mkdir $temporary_storage_directory
  sudo chmod 777 $temporary_storage_directory
  cd $temporary_storage_directory
  sudo curl -o public-key $i
  gpg --import public-key
  cd ..
  sudo rm -r $temporary_storage_directory
done
