#!/bin/sh
bookmark=$(cat $BOOKMARKS/bookmark_titles | dmenu -p "remove bookmark" -i -l 30) #List out bookmarks
[[ -n $bookmark ]] || exit
idx=$(grep -nx "$bookmark" $BOOKMARKS/bookmark_titles | cut -f1 -d:)
sed -i "$idx{d}" $BOOKMARKS/bookmarks && sed -i "$idx{d}" $BOOKMARKS/bookmark_titles && notify-send "$bookmark bookmark removed"
