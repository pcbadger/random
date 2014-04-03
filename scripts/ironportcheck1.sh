#mxchecker.sh
INPUT1="day3-ironport-ICID.csv"
INPUT2="INPUT/day3-ironport-address-all.csv"
OUTPUT="OUTPUT/day3-ironport-ip-out.csv"
#while read f1
#do

for i in `cat INPUT/${INPUT1}`

do

#AUTH_ICID=`cat $i | grep Auth | cut -d " " -f 10 | sed 's/)//'`

AUTH_IP=`cat $INPUT2 | grep "$i" | grep interface | cut -d " " -f 15,16 | sed 's/ reverse//' | sed 's/address //'`
#grep interface | cut -d " " -f 7`
#| cut -d " " -f 15`
# | sed 's/ /,/'`


#echo LOOP
echo $i
#echo $AUTH_ICID
echo $AUTH_IP >> "$OUTPUT" 

#AUTH_IP_LIST=`cat $AUTH_IP | sed 's/ /\n/'`

#echo $AUTH_IP

#MXCHECK1=`host -t mx "$i" | grep 'handled'`

#MXCHECK1=`host -t mx "$i" | grep 'mail.cl.com\|mail.clientinternet\|d-o-m-a-i-n'`
#MXCHECK2

#echo "MXCHECK1 $MXCHECK1"
#if [ "$MXCHECK1" = "" ]; then
	#MXOUT='NULL - NO MX RECORDS'
#	echo "NULL - NO MX RECORDS |$i" >> "$OUTPUT"
#
#else
#	shopt -s nocasematch
#	if [[ "$MXCHECK1" =~ .*mail.cl.com.* ]] || [[ "$MXCHECK1" =~ .*clientinternet.* ]] || [[ "$MXCHECK1" =~ .*domain.* ]] || [[ "$MXCHECK1" =~ .*d-o-m-a-i-n.* ]] ; then

#		MXOUT=$MXCHECK1
#		echo "OURS: |$i| $MXOUT" >> "$OUTPUT"
#	else
#		MXOUT=`echo $MXCHECK1 | sed 's/.*\\n//' | sed 's/.*\handled by//'`
#		#echo "NOT OURS: $i: $MXOUT"
#		STRANGEMX=`echo $MXCHECK1 | sed 's/.*\ //'`
#		#echo $STRANGEMX
#		STRANGEMXIP=`host -t a "$STRANGEMX" | sed 's/.*\ //'`
#		echo "NOT OURS: |$i| $MXOUT WITH IP | $STRANGEMXIP" >> "$OUTPUT"
#
#	fi
#fi

#echo "$i: $MXOUT"

#CHECK2=`cat $CHECK1 | cut  -f 1`

#echo $CHECK1
#echo "$CHECK1" >> "$OUTPUT" 

done 
#< etrn-mx3.csv
