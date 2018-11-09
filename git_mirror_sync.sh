#!/bin/bash

dest_path="$1"
repo_list_file="$2"

cat "$repo_list_file" | while read line
do
	repo="$(echo "$line" | sed -e 's/\s*$//')"
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
done
