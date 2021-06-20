#!/bin/sh
bookmark=$(dmenu -h 40 -p "remove bookmark" -i -l 30 < "$BOOKMARKS"/bookmark_titles) #List out bookmarks
[ -n "$bookmark" ] || exit
idx=$(grep -nx "$bookmark" "$BOOKMARKS"/bookmark_titles | cut -f1 -d:)
sed -i "$idx{d}" "$BOOKMARKS"/bookmarks && sed -i "$idx{d}" "$BOOKMARKS"/bookmark_titles && notify-send "$bookmark bookmark removed"
