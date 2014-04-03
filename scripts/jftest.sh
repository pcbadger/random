INPUT="input3.csv"
#FS="\"|\""
#FS="\ ,\ |\ "
#FS='|'
#OFS='|'
for i in `cat ${INPUT}`

do
#USERNAME=`echo $i | awk -v  FS=',' -v OFS='|' '{print $1}'`
USERNAME=`echo $i | awk 'BEGIN{FS="[|,:]"} ; {print $1}'`
echo "username: $USERNAME"

done
