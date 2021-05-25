#!/bin/sh
alias browse="$BROWSER"
if [ "$BROWSER" = "surf" ]; then
	alias browse="tabbed -r2 $BROWSER -e x"
fi

if [ -s $BOOKMARKS/bookmark_titles ]; then
	bookmark=$(sed "\$a\search" $BOOKMARKS/bookmark_titles | dmenu -i -l 30)
else 
	bookmark=$(printf "search" | dmenu -i -p "Choose search for search menu" -l 30)
fi
[[ -n $bookmark ]] || exit
idx=$(grep -nF "$bookmark" $BOOKMARKS/bookmark_titles | cut -f1 -d:)

if [ "$bookmark" = "search" ]; then
	engine=$(printf "YouTube\\nDuckDuckGo\\nSearx\\n1337x\\nbol" | dmenu -i -p "Choose Engine" -l 30)
	case $engine in
		YouTube) choice=$(dmenu -i -p "Youtube") && browse "https://www.youtube.com/results?search_query=""$choice" && exit;;
		DuckDuckGo) choice=$(dmenu -i -p "DuckDuckGo") && browse "https://duckduckgo.com/?q=""$choice" && exit;;
		Searx) choice=$(dmenu -i -p "Searx") && browse "https://searx.bar/search?q=""$choice" && exit;;
		1337x) choice=$(dmenu -i -p " 1337x") && browse "https://1337x.to/search/""$choice""/1/" && exit;;
		bol) choice=$(dmenu -i -p " bol") && browse "https://www.bol.com/nl/s/?searchtext=""$choice" && exit;;
	esac
else 
	[[ $idx ]] && sed -n "$idx{p}" $BOOKMARKS/bookmarks | browse && exit || 
		curl -s --head  --request GET "$bookmark" | grep "HTTP" > /dev/null && 
		browse "$bookmark" && exit || browse "https://duckduckgo.com/?q=""$bookmark" && exit
fi
