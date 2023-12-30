#!/usr/bin/env bash

steamappsPath=$1

if [ "$steamappsPath" == "" ]
then
  echo "Usage: $0 [ \"steamapps directory\" ]"
  echo "This program will look through all compdata folders"
  echo "and give you the Steam Titles."
  exit
fi

for dir in "$steamappsPath"/compatdata/*
do
  steamId=$(basename "$dir")
  steamId=${steamId%\n}
  title=$(curl -s "https://store.steampowered.com/api/appdetails/?appids=$steamId" | jq ".[].data.name")

  echo "$steamId: $title"
done