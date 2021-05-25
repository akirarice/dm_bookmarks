#!/bin/sh
alias browse="$BROWSER"
if [ "$BROWSER" = "surf" ]; then
	alias browse="tabbed -r2 $BROWSER -e x"
fi

if [ -s $BOOKMARKS/bookmark_titles ]; then
	bookmark=$(sed "a\search" $BOOKMARKS/bookmark_titles | dmenu -i -l 30)
else 
	bookmark=$(printf "search" | dmenu -i -p "Choose search to to go search menu")
fi

[[ -n $bookmark ]] || exit 
idx=$(grep -nF "$bookmark" $BOOKMARKS/bookmark_titles | cut -f1 -d:)
if [ "$bookmark" = "search" ]; then
	engine=$(printf "YouTube\\nDuckDuckGo" | dmenu -i -p "Choose Engine" -l 30)
	case $engine in
		YouTube) choice=$(dmenu -i -p "YouTube") && browse "https://www.youtube.com/results?search_query=""$choice" && exit;;
		DuckDuckGo) choice=$(dmenu -i -p "DuckDuckGo") && browse "https://duckduckgo.com/?q=""$choice" && exit;;
		Searx) choice=$(dmenu -i -p "Searx") && browse "https:/searx.bar/search?q=""$choice" && exit;;
	esac
else 
	[[ $idx ]] && sed -n "$idx{p}" $BOOKMARKS/bookmarks | browse && exit || 
		curl -s --head  --request GET "$bookmark" | grep "HTTP" > /dev/null && 
		browse "$bookmark" && exit || browse "https://duckduckgo.com/?q=""$bookmark" && exit
fi
