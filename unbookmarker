#!/bin/sh
#1.a Get list of bookmarks by title
#1.b If nothing typed / selected, exit
#2 If the selection is a match to the titles file, get its index 
#3a Check if the index variable was filled,pull the webpage from that index and launch browser
#3b If no index found, check if selection is a website and go it
#3c If Selection is not a website, open up a search instance

bookmark=$(cat $BOOKMARKS/bookmark_titles | dmenu -p "remove bookmark" -i -l 30) #List out bookmarks
[[ -n $bookmark ]] || exit #If nothing chosen, Exit
idx=$(grep -nF "$bookmark" $BOOKMARKS/bookmark_titles | cut -f1 -d:)
sed -i "$idx{d}" $BOOKMARKS/bookmarks && sed -i "$idx{d}" $BOOKMARKS/bookmark_titles && notify-send "$bookmark bookmark removed"
