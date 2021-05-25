#!/bin/sh
alias browse="$BROWSER"
if [ "$BROWSER" = "surf" ]; then
	alias browse="tabbed -r2 $BROWSER -e x"
fi
bookmark=$(cat $BOOKMARKS/bookmark_titles | dmenu -i -l 30)
[[ -n $bookmark ]] || exit 
idx=$(grep -nF "$bookmark" $BOOKMARKS/bookmark_titles | cut -f1 -d:)
[[ -n $idx ]] && sed -n "$idx{p;q}" $BOOKMARKS/bookmarks | xargs -I {} browse "{}" && exit || 
	curl -s --head  --request GET "$bookmark" | grep "HTTP" > /dev/null && browse "$bookmark" && exit || 
	browse "https://duckduckgo.com/?q=""$bookmark"
