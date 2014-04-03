CSV_IN="maildir-sorted2.csv"
DBUSER="root"
DBPASS="###REDACTEDPASSWORD###"
DBNAME="vmail"
TABLEIN="vmail"


for u in `cat ${CSV_IN}`


do

DIRNAME=${u/^.*\X(.*)/}
#DIRNAME=${u%\\*}

echo $DIRNAME

done
