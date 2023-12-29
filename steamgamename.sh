#!/usr/bin/env bash

steamappsPath=$1

if [ "$steamappsPath" == "" ]
then
  echo "Usage: $0 [ \"steamapps directory\" ]"
  echo "This program will look through all compdata folders"
  echo "and give you the Steam Titles."
fi

for dir in "$steamappsPath"/compdata/*
do
  steamId=$(basename "$dir")
  echo "$steamId"
done

#curl "https://store.steampowered.com/api/appdetails/?appids=200260" | python3 -c "import sys, json; print(json.load(sys.stdin)['200260']['data']['name'])"