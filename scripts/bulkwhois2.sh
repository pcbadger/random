#mxchecker.sh
IP_COUNTRY_LIST="INPUT/IP-COUNTRY-LIST3.csv"
INPUT1="INPUT/day3-ironport-IP-shortlist3.csv"
#INPUT2="ironport-addresses.txt"
OUTPUT="OUTPUT/day3-ironport-whois-shortout2.csv"
#while read f1
#do

for i in `cat ${INPUT1} `

do

#CLEAN=`echo i | sed 's/"//' | sed 's/,//'`


CHECKLIST=
echo "cat $IP_COUNTRY_LIST | grep $i"


if [ "$CHECKLIST" = "" ]; then

#	CHECK1=`whois $i | grep -i country | sed 's/://' `
#	CHECK2=`echo $CHECK1 | sed 's/country//i' | sed 's/ //'`
#	CHECK3=`echo $CHECK2 | sed 's/ /\|/' | cut -d \| -f 1` 
##	CHECK4=`echo $CHECK3 | cut -d \| -f 1`
	FINAL="who|$i|$CHECK3"
else
	FINAL="list|$CHECKLIST"

fi


echo $FINAL
echo "$FINAL" >> "$OUTPUT" 

done 
#< etrn-mx3.csv
