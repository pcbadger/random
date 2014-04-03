#mxchecker.sh
INPUT="INPUT/crapmaildb20142.csv"
OUTPUT="OUTPUT/crapmaildb-fixed"
#while read f1
#do

for i in `cat ${INPUT}`

do
OUTPUT=`echo $i | sed 's/\n/{BREAK}/'`

echo $OUTPUT

done
