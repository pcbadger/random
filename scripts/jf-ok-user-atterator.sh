INPUT="INPUT/all-addresses.csv"
INPUT2="INPUT/crapmail-ok-users.csv"
OUTPUT="OUTPUT/crapmail-ok-users-with-at.csv"

for i in `cat ${INPUT2}`

do

			  echo $i@ >> $OUTPUT;

	done
