#!/bin/bash
shopt -s nullglob
feh_args=(--draw-filename --draw-exif --magick-timeout 10 --image-bg black -g 800x600)

if [[ ! -f $1 ]]; then
	printf '%s\n' "$0: first argument is not a file" >&2
	exit 1
fi

file=$(basename -- "$1")
dir=$(dirname -- "$1")
shift

cd -- "$dir" || exit
IFS=$'\n\b'

for i in ./*.{png,jpg,jpeg,gif} ; do
	if [[ ! -f $i ]]; then
		continue
	else
		arr+=("$i")
	fi

	if [[ $i == "$file" ]]; then
		c=$((${#arr[@]} - 1))
	fi
done

feh "${feh_args[@]}" "$@" -- "${arr[@]:c}" "${arr[@]:0:c}" >/dev/null 2>&1
