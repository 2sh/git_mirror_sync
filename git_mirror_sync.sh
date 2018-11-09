#!/bin/sh

dest_path="$1"
repo_list_file="$2"

while read -r line
do
	repo="$(echo "$line" | tr -d '[:space:]')"
	if [ -z "$repo" ]
	then
		continue
	fi
	
	mirror_path="$dest_path/${repo##*/}"
	
	if [ -d "$mirror_path" ]
	then
		git -C "$mirror_path" remote update
	else
		git clone --mirror "$repo" "$mirror_path"
	fi
done < "$repo_list_file"
