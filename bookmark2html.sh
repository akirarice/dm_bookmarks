#!/bin/sh
echo "<!DOCTYPE NETSCAPE-Bookmark-file-1>" >> $BOOKMARKS/bookmarks.html
echo '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">' >> $BOOKMARKS/bookmarks.html
echo '<TITLE>Bookmarks</TITLE>' >> $BOOKMARKS/bookmarks.html
echo '<H1>Bookmarks</H1>' >> $BOOKMARKS/bookmarks.html
echo '<DL><p>' > $BOOKMARKS/bookmarks.html
  cat $BOOKMARKS/bookmarks |
  while read L; do
    echo -n '    <DT><A HREF="' >> $BOOKMARKS/bookmarks.html;
        echo ''"$L"'">'"$L"'</A>' >> $BOOKMARKS/bookmarks.html;
  done
echo "</DL><p>" >> $BOOKMARKS/bookmarks.html
