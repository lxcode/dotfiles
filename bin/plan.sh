#!/bin/sh
# SLOPPY!

SRC=/home/lx/.plan
DESTDIR=/home/lx/www/0/plan
DEST=$DESTDIR/index.html
DATE=`echo |tai64n|sed -e 's/ //'`

if [ $SRC -nt $DESTDIR/plan.txt ]; then

	echo $DATE > $DESTDIR/plan.txt
	grep -v -h -e 'Login:' -e 'Directory:' $SRC >> $DESTDIR/plan.txt
	cp $DESTDIR/plan.txt $DESTDIR/plan$DATE.txt
fi

cp $DESTDIR/template.html $DEST.tmp
cp $DESTDIR/rss.tmpl $DESTDIR/rss.xml

for file in `ls -r $DESTDIR/plan@*.txt`; do
	TMPDATE=`basename $file |sed -e 's/plan//' -e 's/\.txt//'`
	sed -e 's/{http.*}/<a href="&">&<\/a>/' $file | sed -e 's/{//g' -e 's/}//g' >> $DEST.tmp
	echo -n "<br><a href=\"mailto:lx-plan@redundancy.redundancy.org?subject=$TMPDATE\">Comment</a> " >> $DEST.tmp
	echo "<a href=\"http://redundancy.redundancy.org/plan/plan$TMPDATE.html\">Link</a> " >> $DEST.tmp
	echo '<br><br><hr>' >> $DEST.tmp

	cp $DESTDIR/template.html $DESTDIR/plan$TMPDATE.html
	sed -e 's/{http.*}/<a href="&">&<\/a>/' $file | sed -e 's/{//g' -e 's/}//g' >> $DESTDIR/plan$TMPDATE.html
	echo -n "<br><a href=\"mailto:lx-plan@redundancy.redundancy.org?subject=$TMPDATE\">Comment</a> " >> $DESTDIR/plan$TMPDATE.html
	echo "<a href=\"http://redundancy.redundancy.org/plan/plan$TMPDATE.html\">Link</a> " >> $DESTDIR/plan$TMPDATE.html
	echo '<br><br>' >> $DESTDIR/plan$TMPDATE.html

	PROJECT=`grep Project $DESTDIR/plan$TMPDATE.txt | sed -e "s/Project: //g"`
	# Do RSS
	echo "<item>" >> $DESTDIR/rss.xml
	echo "<link>http://redundancy.redundancy.org/plan/plan$TMPDATE.html</link>" >> $DESTDIR/rss.xml
	echo "<title>$PROJECT</title>" >> $DESTDIR/rss.xml
	echo "<description></description>" >> $DESTDIR/rss.xml
	echo "</item>" >> $DESTDIR/rss.xml
done

echo '</channel></rss>' >> $DESTDIR/rss.xml
echo '</pre></body></html>' >> $DEST.tmp
cp $DEST.tmp $DEST
