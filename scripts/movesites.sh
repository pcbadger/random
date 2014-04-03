#$  sitemove.sh
while read f1 f2
do

mv "$f1" "$f2"

done < movesites.csv

