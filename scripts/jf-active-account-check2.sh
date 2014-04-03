CSV_IN="maildir-list.csv"
CSV_OUT="domain-check-out-1.csv"
DBUSER="root"
DBPASS="###REDACTEDPASSWORD###"
DBNAME="vmail"
TABLEIN="vmail"

for u in `cat ${CSV_IN}`

do

MAILDIR=`echo $u | awk -F, '{print $1}'`

#echo "Maildir: $MAILDIR"

CRAPMAILUSER=`echo $MAILDIR | sed 's/.*\\\//'`

USER_DOMAIN_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT USERNAME, DOMAIN, DEL_LOCAL, ACCESS_POP3, ACCESS_RECEIVE, AUTO_ENABLED, MAILBOX_DIRECTORY, HOME_WEB  FROM "$DBNAME"."$TABLEIN" WHERE MAILBOX_DIRECTORY = CONVERT( _utf8 '$MAILDIR' USING latin1 ) COLLATE latin1_swedish_ci" | sed 's/\*/STAR/g'`

USER_DOMAIN_LIST=$(echo $USER_DOMAIN_FROM_DB | sed 's/ /|/g' | sed 's/\*/STAR/g')
# | sed 's/}\+/\n/g')

echo $USER_DOMAIN_LIST 

#for q in $USER_DOMAIN_LIST
#
#do

#USERNAME=`echo $q | awk -F, '{print $1}'`

#DOMAIN=`echo $q | awk -F, '{print $2}'`

#DEL_LOCAL=`echo $q | awk -F, '{print $3}'`

#ACCESS_POP3=`echo $q | awk -F, '{print $4}'`

#ACCESS_RECEIVE=`echo $q | awk -F, '{print $5}'`

#AUTO_ENABLED=`echo $q | awk -F, '{print $6}'`

#MAILBOX_DIRECTORY=`echo $q | awk -F, '{print $7}'`

#done

#if [ X"$ALTUSER2" == X"@" ]; then
#	ALTUSER2=""
#	ALTUSER3=""
#	ALTUSER4=""
#        ALTUSER5=""
#        ALTUSER6=""
#elif [ X"$ALTUSER3" == X"@" ]; then
#        ALTUSER3=""
#        ALTUSER4=""
#        ALTUSER5=""
#        ALTUSER6=""
#elif [ X"$ALTUSER4" == X"@" ]; then
#        ALTUSER4=""
#        ALTUSER5=""
#        ALTUSER6=""
#elif [ X"$ALTUSER5" == X"@" ]; then
#        ALTUSER5=""
#        ALTUSER6=""
#elif [ X"$ALTUSER6" == X"@" ]; then
#        ALTUSER6=""
#
#else
#	:
#fi

#USER_INFO_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -N -e "SELECT VOPPASS, DEL_LOCAL, ACCESS_POP3, ACCESS_RECEIVE, AUTO_ENABLED, FORWARD_TO, AUTO_MESSAGE FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci" | sed 's/\t/|/g' | sed 's/ /{SPACE}/g'`

#for d in $USER_INFO_FROM_DB

#do


#PASS_FROM_DB=`echo $d | cut -d'|' -f 1`
#DEL_LOCAL_FROM_DB=`echo $d | cut -d'|' -f 2`
#ACCESS_POP3_FROM_DB=`echo $d | cut -d'|' -f 3`
#ACCESS_RECEIVE_FROM_DB=`echo $d | cut -d'|' -f 4`
#AUTO_ENABLED_FROM_DB=`echo $d | cut -d'|' -f 5`
#FORWARD_TO_FROM_DB=`echo $d | cut -d'|' -f 6`
#AUTO_MESSAGE_FROM_DB=`echo $d | cut -d'|' -f 7`

#done

#PASS_PROCESSED=`echo $PASS_FROM_DB | sed 's/|/{PIPE}/g'`

#echo $CRAPMAILUSER
#echo "$CRAPMAILUSER|$PASS_PROCESSED|$ALTUSER1|$ALTUSER2|$ALTUSER3|$ALTUSER4|$ALTUSER5|$ALTUSER6|$FORWARD_TO_FROM_DB|$DEL_LOCAL_FROM_DB|$ACCESS_POP3_FROM_DB|$ACCESS_RECEIVE_FROM_DB|$AUTO_ENABLED_FROM_DB|$AUTO_MESSAGE_FROM_DB|" >> "$CSV_OUT"

done

