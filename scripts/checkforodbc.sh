#$  checkforodbc.sh
while read f1 f2
do

grep -R DSN  /dell4/"$f1" 

done < ni-web4-sites.csv

