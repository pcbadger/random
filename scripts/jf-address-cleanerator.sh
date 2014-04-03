INPUT="INPUT/all-addresses.csv"
INPUT2="OUTPUT/crapmail-ok-users-with-at.csv"
OUTPUT="OUTPUT/crapmail-unconfirmed-users.csv"

for i in `cat ${INPUT}`

do

user=`echo $i  | awk -F@ '{print $1}'`
userat=`echo $user'@'`

echo $userat

wonka=`cat ${INPUT2} | grep $userat | wc -l`

if [[ $wonka = 0 ]];

		then
#
#			  echo  $i "It's skippola'd!";
#			else
			  echo $i >> $OUTPUT;
			else
                         echo  $i "It's skippola'd!";
		fi	

	done
#done 
