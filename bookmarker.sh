#!/bin/sh
bookmark=$(xclip -o -selection p)
title=$(wget -qO- "$bookmark" | grep -o -P '(?<=<title>).*(?=</title>)')

[ -z "$title" ] && notify-send "url title not found" 
curl -s --head --request --fail "$bookmark" || notify-send "warning: url not valid" 

if grep -qx "$bookmark" "$BOOKMARKS"/bookmarks; then
	notify-send "'$bookmark' already in bookmarks"
else
	request=$(printf "Yes\\nNo" | dmenu -h 40 -i -p "Add $bookmark to bookmarks?") || exit
                [ "$request" = "Yes" ] && echo "$bookmark" >> "$BOOKMARKS"/bookmarks 
		[ -z "$title" ] && echo "$bookmark" >> "$BOOKMARKS"/bookmark_titles &&
			notify-send "$bookmark added to bookmarks" || 
			echo "$title" >> "$BOOKMARKS"/bookmark_titles && 
			notify-send "$title added to bookmarks"
fi
