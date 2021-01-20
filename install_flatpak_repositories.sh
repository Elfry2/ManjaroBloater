#!/bin/bash

repositories=(
  flathub\ https://dl.flathub.org/repo/flathub.flatpakrepo
)

for i in "${repositories[@]}"
do
  sudo flatpak remote-add --if-not-exists $i
done
