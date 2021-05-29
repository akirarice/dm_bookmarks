#!/bin/sh
bookmark=$(xclip -o -selection clipboard)
title=$(wget -qO- $bookmark |
  gawk -v IGNORECASE=1 -v RS='</title' 'RT{gsub(/.*<title[^>]*>/,"");print;exit}')

[ -z "$title" ] && notify-send "url not found" && exit

if grep -qx "$title" $BOOKMARKS/bookmark_titles; then
	notify-send "'$title' already in bookmarks"
else
	request=$(printf "Yes\\nNo" | dmenu -i -p "Add $bookmark to bookmarks?") || exit
                [ "$request" = "Yes" ] && echo "$bookmark" >> $BOOKMARKS/bookmarks && echo "$title" >> $BOOKMARKS/bookmark_titles && 
			notify-send "$title added to bookmarks"
fi
