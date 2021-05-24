#!/bin/sh
#If you use a browser not listed in the case statment, just add it
#1.a Get list of bookmarks by title
#1.b If nothing typed / selected, exit
#2 If the selection is a match to the titles file, get its index
#3a Check if the index variable was filled,pull the webpage from that index and launch browser
#3b If no index found, check if selection is a website and go it
#3c If Selection is not a website, open up a search instance

bookmark=$(cat $BOOKMARKS/bookmark_titles | dmenu -i -l 30) #List out bookmarks
[[ -n $bookmark ]] || exit #If nothing chosen, Exit
idx=$(grep -nF "$bookmark" $BOOKMARKS/bookmark_titles | cut -f1 -d:)
case $BROWSER in
	surf) [[ -n $idx ]] && sed -n "$idx{p;q}" $BOOKMARKS/bookmarks | xargs -I {} tabbed -r2 $BROWSER -e x "{}" && exit || 
		curl -s --head  --request GET "$bookmark" | grep "HTTP" > /dev/null && tabbed -r2 $BROWSER -e x "$bookmark" && exit || 
		tabbed -r2 $BROWSER -e x "https://duckduckgo.com/?q=""$bookmark";;
	brave|*fox|chromium|icecat) [[ -n $idx ]] && sed -n "$idx{p;q}" $BOOKMARKS/bookmarks | xargs -I {} $BROWSER "{}" && exit || 
		curl -s --head  --request GET "$bookmark" | grep "HTTP" > /dev/null && $BROWSER "$bookmark" && exit || 
		$BROWSER "https://duckduckgo.com/?q=""$bookmark";;
esac
