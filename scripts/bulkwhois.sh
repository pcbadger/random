#mxchecker.sh
INPUT1="OUTPUT/day3-ironport-ip-out-sorted.csv"
#INPUT2="ironport-addresses.txt"
OUTPUT="OUTPUT/day3-ironport-whois-out.csv"
#while read f1
#do

for i in `cat ${INPUT1}`

do

CHECK1=`whois $i | grep -i country | sed 's/:/\|/'`
CHECK2=`echo $CHECK1 | sed 's/ //'`
CHECK3=`echo $CHECK2 | sed 's/ /\|/'`

echo $i
echo "$i|$CHECK3" >> "$OUTPUT" 

done 
#< etrn-mx3.csv
