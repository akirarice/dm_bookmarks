#!/bin/sh
while true; do 
	if [ -s $BOOKMARKS/bookmark_titles ]; then 
		bookmark=$(sed "\$a\Search\\nSwitch" $BOOKMARKS/bookmark_titles | dmenu -i -l 15) 
	else 
		bookmark=$(printf "Search\\nSwitch" | dmenu -i -p "Search/URL") 
	fi
	[[ -n $bookmark ]] || break 
	case $bookmark in
		Search) 
			engine=$(printf "YouTube\\nDuckDuckGo\\nSearx\\n1337x\\nbol\\nstartpage\\nBack" | dmenu -i -p "Engine")
			[[ -n $engine ]] || break 
			case $engine in
				YouTube) choice=$(dmenu -i -p "Youtube") 
					[[ -n $choice ]] && link="https://www.youtube.com/results?search_query=""$choice" || exit
					break 
					;; 
				DuckDuckGo) choice=$(dmenu -i -p "DuckDuckGo") 
					[[ -n $choice ]] && link="https://duckduckgo.com/?q=""$choice" || exit
					break
					;;
				Searx) choice=$(dmenu -i -p "Searx")
					[[ -n $choice ]] && link="https://searx.bar/search?q=""$choice" || exit
					break 
					;;
				1337x) choice=$(dmenu -i -p " 1337x") 
					[[ -n $choice ]] && link="https://1337x.to/search/""$choice""/1/" || exit
					break 
					;;
				bol) choice=$(dmenu -i -p " bol")
					[[ -n $choice ]] && link="https://www.bol.com/nl/s/?searchtext=""$choice" || exit
					break 
					;;
				startpage) choice=$(dmenu -i -p " startpage") 
					[[ -n $choice ]] && link="https://startpage.com/?q=""$choice" || exit
					break
					;;
				Back)  
					;;
				*) link="$bookmark" 
					break
					;;
			esac 
			;; 
		Switch)  newbrowser=$(printf "brave\\nicecat\\nsurf\\nvimb" | dmenu -i -p "Choose Browser")
			;;
		*) 
			idx=$(grep -nF "$bookmark" $BOOKMARKS/bookmark_titles | cut -f1 -d:) 
			if [ "$idx" ]; then 
				link=$(sed "$idx"'!d' $BOOKMARKS/bookmarks)
				break
			else
				link="$bookmark"
				break
			fi
			;; 
	esac
done
[[ -n $link ]] || exit
[[ -n $newbrowser ]] || newbrowser="$BROWSER"
if [ "$newbrowser" = "surf" ] || [ "$newbrowser" = "vimb" ]; then
        newbrowser="tabbed -r2 $newbrowser -e x"
fi

curl -s --head  --request --fail "$link" && $newbrowser "$link" || $newbrowser "https://duckduckgo.com/?q=""$link"
