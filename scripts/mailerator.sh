#mxchecker.sh
ADDRESSES="addresses.csv"
BODY="mailbody.txt"
#while read f1
#do

for i in `cat ${ADDRESSES}`

do


echo $BODY | MAIL -s "You need to change account $i so you do " $i

done
