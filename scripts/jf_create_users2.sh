INPUT="input3.csv"
#FS="\"|\""
#FS="\ ,\ |\ "
FS='|'
OFS='|'
STORAGE_BASE_DIRECTORY="/vmail1/crapmail"
MAILBOX_FORMAT=''
DEFAULT_QUOTA='100'
MAILDIR_STYLE='hashed'
STORAGE_BASE="$(dirname ${STORAGE_BASE_DIRECTORY})"
STORAGE_NODE="$(basename ${STORAGE_BASE_DIRECTORY})"
PAST='1969-07-21 02:56:00'
FUTURE='2363-09-27 12:00:00'

#SQL="output.sql"
#echo '' > ${SQL}
#USE_DEFAULT_PASSWD='YES'


for i in `cat ${INPUT}`

#while read f1 f2 f2 f4 f5
do
CRAPMAILNAME=`echo $i | awk -F, -v OFS='|' '{print $1}'`
DOMAIN=`echo $i | awk -F, '{print $2}'`
DEFAULT_PASSWD=`echo $i | awk -F, '{print $3}'`
FORWARD_TO=`echo $i | awk -F, '{print $4}'`
FORWARD_ONLY=`echo $i | awk -F, '{print $5}'`
AUTO_MESSAGE=`echo $i | awk -F, '{print $7}'`
AUTO_ENABLED=`echo $i | awk -F, '{print $6}'`


#DEFAULT_PASSWD="$3"
#DOMAIN=$f2
#CRAPMAILNAME=$f1
USERNAME=$CRAPMAILNAME"@"$DOMAIN

#echo "$f1"


#if [ X"${USE_DEFAULT_PASSWD}" == X"YES" ]; then
#    export 
#CRYPT_PASSWD="$(openssl passwd -1 ${DEFAULT_PASSWD})"
#else
#    :
#fi

length="$(echo ${CRAPMAILNAME} | wc -L)"
           str1="$(echo ${CRAPMAILNAME} | cut -c1)"
            str2="$(echo ${CRAPMAILNAME} | cut -c2)"
            str3="$(echo ${CRAPMAILNAME} | cut -c3)"

            if [ X"${length}" == X"1" ]; then
                str2="${str1}"
                str3="${str1}"
            elif [ X"${length}" == X"2" ]; then
                str3="${str2}"
            else
                :
            fi

            # Use mbox, will be changed later.
            maildir="/${str1}/${str2}/${str3}/${CRAPMAILNAME}"

echo 
echo 

#echo $FORWARD_ONLY
if [ "$FORWARD_ONLY" == "1" ]; then
FULL_FORWARD="${FORWARD_TO}"
else
FULL_FORWARD="${USERNAME}","${FORWARD_TO}"
fi

if [ -z "$FORWARD_TO" ]; then
FULL_FORWARD="${USERNAME}"
else
	:
fi

#echo $FULL_FORWARD

echo
echo 


echo "INSERT INTO mailbox (username, crapmailname, password, name, storagebasedirectory,storagenode, maildir, quota, domain, active, local_part, created)
    VALUES ('${USERNAME}', '${CRAPMAILNAME}', '${CRYPT_PASSWD}', '${CRAPMAILNAME}', '${STORAGE_BASE}','${STORAGE_NODE}', '${maildir}', '${DEFAULT_QUOTA}', '${DOMAIN}', '1','${USERNAME}', NOW());

INSERT INTO alias (address, goto, domain, created, active) VALUES ('${USERNAME}', '${FULL_FORWARD}','${DOMAIN}', NOW(), 1);

INSERT INTO vacation (email, domain, startdate, enddate, subject, body, created, active) VALUES ('${USERNAME}','${DOMAIN}', ${PAST}, ${FUTURE}, Out Of Office, ${AUTO_MESSAGE}, NOW(), ${AUTO_ACTIVE});
"

echo "crapmailname: $CRAPMAILNAME"
echo "domain: $DOMAIN"
echo "username: $USERNAME"
#echo "passwd: $CRYPT_PASSWD"
echo "maildir: $maildir"
echo "forwards: $FULL_FORWARD"

done
#<file
