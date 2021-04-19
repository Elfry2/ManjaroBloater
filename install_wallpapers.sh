#!/bin/bash

urls=(
	https://cdn.suwalls.com/wallpapers/nature/snowy-rocky-mountains-36084-1920x1200.jpg
	https://images5.alphacoders.com/106/1067637.jpg
)

temporary_storage_directory=elfry_tmp

for i in "${urls[@]}"
do
  sudo wget -nc -P /usr/share/backgrounds $i
done
