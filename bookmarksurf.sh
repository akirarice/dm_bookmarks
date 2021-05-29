#!/bin/sh
while true; do 
	bookmark=$(printf "Bookmarks\\nSwitch Browser\\nYouTube\\nSearx\\nbol" | dmenu -i) ; [[ -n $bookmark ]] || exit 
	case $bookmark in
		YouTube) choice=$(dmenu -i -p "Youtube") ; [[ -n $choice ]] && link="https://www.youtube.com/results?search_query=""$choice" || exit ; break ;;
		Searx) choice=$(dmenu -p " Searx") ; [[ -n $choice ]] && link="https://searx.bar/search?q=""$choice" || exit ; break ;; 
		1337x) choice=$(dmenu -p " 1337x") ; [[ -n $choice ]] && link="https://1337x.to/search/""$choice""/1/" || exit ; break ;; 
		bol) choice=$(dmenu -p " bol") ; [[ -n $choice ]] && link="https://www.bol.com/nl/s/?searchtext=""$choice" || exit ; break ;; 
		"Switch Browser") newbrowser=$(printf "brave\\nsurf\\nvimb" | dmenu -i -p "Choose Browser") ;; 
		Bookmarks) 
			if [ -s $BOOKMARKS/bookmark_titles ]; then 
				choice=$(cat $BOOKMARKS/bookmark_titles | dmenu -i -l 10) 
				idx=$(grep -nF "$choice" $BOOKMARKS/bookmark_titles | cut -f1 -d:) 
			else 
				link=$(dmenu -p "Search/URL") ; break
			fi ;;
		*) link="$bookmark" ; break ;;
	esac
done
[[ -n $link ]] || exit ; [[ -n $newbrowser ]] || newbrowser="$BROWSER"
[[ "$newbrowser" = "surf" ]] || [[ "$newbrowser" = "vimb" ]] && newbrowser="tabbed -r2 $newbrowser -e x"
[[ -n $choice ]] || [[ $idx ]] && $newbrowser "$link" && exit || 
	curl -s --head  --request --fail "$link" && $newbrowser "$link" || $newbrowser "https://duckduckgo.com/?q=""$link"
