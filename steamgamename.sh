#!/usr/bin/env bash

steamappsPath=$1
steamappsRegex='^.*steamapps\/?\r?\n?'

if [ "$steamappsPath" == "" ]; then
  echo "Usage: $0 [ \"steamapps directory\" ]"
  echo "This program will look through all compdata folders"
  echo "and give you the Steam Titles."
  exit
fi

if ! [[ "$steamappsPath" =~ $steamappsRegex ]]; then
  echo "Path should end with steamapps"
  exit
fi

if test -d "$steamappsPath"; then
  for dir in "$steamappsPath"/compatdata/*; do
    isInstalled=""
    steamId=$(basename "$dir")
    steamId=${steamId%\n}
    title=$(curl -s "https://store.steampowered.com/api/appdetails/?appids=$steamId" | jq ".[].data.name")
    if test -f "$steamappsPath/appmanifest_$steamId.acf"; then
      isInstalled="[Installed]"
    fi

    echo "$steamId: $title $isInstalled"
  done
else
  echo "Please enter a valid steamapps directory"
fi
