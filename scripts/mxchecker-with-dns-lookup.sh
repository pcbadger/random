#mxchecker.sh
INPUT="INPUT/crapmail-domains-on-billing.csv"
OUTPUT="OUTPUT/crapmail-mx-checkout-with-dns-bill.csv"
#while read f1
#do

for i in `cat ${INPUT}`

do


MXCHECK1=`host -t mx "$i" | grep 'handled'`

#MXCHECK1=`host -t mx "$i" | grep 'mail.cl.com\|mail.clientinternet\|d-o-m-a-i-n'`
#MXCHECK2

echo "MXCHECK1 $MXCHECK1"
if [ "$MXCHECK1" = "" ]; then
	#MXOUT='NULL - NO MX RECORDS'
	echo "NULL - NO MX RECORDS |$i" >> "$OUTPUT"

else
	shopt -s nocasematch
       DNSCHECK1=`whois "$i" | grep 'dns1.company.net'`
       if [[ "$DNSCHECK1" == "" ]] ; then
                DNSOUT="NON COMPANY DNS"
       else
                DNSOUT="COMPANY DNS"
       fi

	if [[ "$MXCHECK1" =~ .*mail.cl.com.* ]] || [[ "$MXCHECK1" =~ .*clientinternet.* ]] || [[ "$MXCHECK1" =~ .*domain.* ]] || [[ "$MXCHECK1" =~ .*d-o-m-a-i-n.* ]] ; then

		MXOUT=$MXCHECK1
		echo "OURS: |$i| $MXOUT |$DNSOUT" >> "$OUTPUT"
	else
		MXOUT=`echo $MXCHECK1 | sed 's/.*\\n//' | sed 's/.*\handled by//'`
		#echo "NOT OURS: $i: $MXOUT"
		STRANGEMX=`echo $MXCHECK1 | sed 's/.*\ //'`
		#echo $STRANGEMX
		STRANGEMXIP=`host -t a "$STRANGEMX" | sed 's/.*\ //'`
		echo "NOT OURS: |$i| $MXOUT |$DNSOUT WITH IP | $STRANGEMXIP" >> "$OUTPUT"

	fi
fi

echo "$i: $MXOUT: $DNSOUT"


#>> /tmp/out-etrn-mx.txt

done 
#< etrn-mx3.csv
