#mxchecker.sh
INPUT1="OUTPUT/day3-ironport-ip-out.csv"
INPUT2="day3-ironportauth2.txt"
INPUT3="OUTPUT/day3-ironport-whois-out-sorted2.csv"
OUTPUT="OUTPUT/ironport-cross-ref-out4.csv"
#while read f1
#do

for i in `cat ${INPUT1}`

do

#IP=`echo $i | cut -d \| -f 2`
#SOURCE=`echo $i | cut -d \| -f 1`
#COUNTRY=`echo $i | cut -d \| -f 3`

#echo $IP
CROSSCHECK1=`cat $INPUT2 | grep interface | grep $i | wc -l`
#CROSSCHECK1=`cat $INPUT2 | grep interface | grep $i | cut -d " " -f 15`
CROSSCHECK2=`cat $INPUT3 | grep $i`

#	for UNIT in $CROSSCHECK1;
#	do
#	BLAH=`echo $UNIT | sed 's/ /,/'` ;
#	echo $BLAH
#	done

#echo "$CROSSCHECK1"

#echo "$i: $MXOUT"

#CHECK2=`cat $CHECK1 | cut  -f 1`

#echo "$COUNTRY|$IP|$CROSSCHECK1|$SOURCE"
echo "$i"
echo "$CROSSCHECK2|$CROSSCHECK1" >> "$OUTPUT" 

done 
#< etrn-mx3.csv
