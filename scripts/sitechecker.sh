#t sitechecker.sh
while read f1
do

host -t a "$f1" >> /tmp/out-etrn-mx.txt

done < etrn-mx3.csv
