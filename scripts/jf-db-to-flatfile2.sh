CSV_IN="crapmail-sample1.csv"
DBUSER="root"
DBPASS="###REDACTEDPASSWORD###"
DBNAME="vmail"
TABLEIN="vmail"

for u in `cat ${CSV_IN}`

do

MAILDIR=`echo $u | awk -F, '{print $1}'`

#echo "Maildir: $MAILDIR"

CRAPMAILUSER=`echo $MAILDIR | sed 's/.*\\\//'`
#CRAPMAILUSER=`echo $MAILDIR | cut -d '\' -f 29`
#CRAPMAILUSER=${u%\*}

#echo $CRAPMAILUSER

USER_DOMAIN_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT USERNAME , DOMAIN FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN != CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`

#USER_DOMAIN_FROM_DB=`mysql -uroot -p###REDACTEDPASSWORD### -s -N -e "SELECT USERNAME , DOMAIN FROM vmail.vmail WHERE DOMAIN != CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%02-190-6%' USING latin1 ) COLLATE latin1_swedish_ci"`

#echo "crapmailuser: $CRAPMAILUSER"

#echo "user domain from DB: $USER_DOMAIN_FROM_DB"
USER_DOMAIN_LIST=$(echo $USER_DOMAIN_FROM_DB | sed 's/ /,/g')
#echo "user domain list: $USER_DOMAIN_LIST"


for q in $USER_DOMAIN_LIST

do

ALTUSER1=`echo $q | awk -F, '{print $1 "@" $2}'`

#echo "Alt user 1: $ALTUSER1"

ALTUSER2=`echo $q | awk -F, '{print $3 "@" $4}'`

#echo "Alt user 2: $ALTUSER2"

ALTUSER3=`echo $q | awk -F, '{print $5 "@" $6}'`

#echo "Alt user 3: $ALTUSER3"

ALTUSER4=`echo $q | awk -F, '{print $7 "@" $8}'`

#echo "Alt user 4: $ALTUSER4"

ALTUSER5=`echo $q | awk -F, '{print $9 "@" $10}'`

ALTUSER6=`echo $q | awk -F, '{print $11 "@" $12}'`


done

if [ X"$ALTUSER2" == X"@" ]; then
	ALTUSER2=""
	ALTUSER3=""
	ALTUSER4=""
        ALTUSER5=""
        ALTUSER6=""
elif [ X"$ALTUSER3" == X"@" ]; then
        ALTUSER3=""
        ALTUSER4=""
        ALTUSER5=""
        ALTUSER6=""
elif [ X"$ALTUSER4" == X"@" ]; then
        ALTUSER4=""
        ALTUSER5=""
        ALTUSER6=""
elif [ X"$ALTUSER5" == X"@" ]; then
        ALTUSER5=""
        ALTUSER6=""
elif [ X"$ALTUSER6" == X"@" ]; then
        ALTUSER6=""

else
	:
fi

USER_INFO_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -N -e "SELECT VOPPASS, DEL_LOCAL, ACCESS_POP3, ACCESS_RECEIVE, AUTO_ENABLED, FORWARD_TO, AUTO_MESSAGE FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci" | sed 's/\t/|/g' | sed 's/ /{SPACE}/g'`

#USER_INFO_LIST=$(echo $USER_INFO_FROM_DB | sed 's/^M\n/ARSE/g')

#USER_INFO_LIST=`echo $USER_INFO_FROM_DB | sed ':a;N;$!ba;s/\n/{BREAK}/g'`
#USER_INFO_LIST=$(echo $USER_INFO_FROM_DB | sed 's/ /|/g')

#| sed 's/\t/ARSE/g'

#echo $USER_INFO_FROM_DB
#echo $USER_INFO_LIST



for d in $USER_INFO_FROM_DB

do


PASS_FROM_DB=`echo $d | cut -d'|' -f 1`
DEL_LOCAL_FROM_DB=`echo $d | cut -d'|' -f 2`
ACCESS_POP3_FROM_DB=`echo $d | cut -d'|' -f 3`
ACCESS_RECEIVE_FROM_DB=`echo $d | cut -d'|' -f 4`
AUTO_ENABLED_FROM_DB=`echo $d | cut -d'|' -f 5`
FORWARD_TO_FROM_DB=`echo $d | cut -d'|' -f 6`
AUTO_MESSAGE_FROM_DB=`echo $d | cut -d'|' -f 7`


#PASS_FROM_DB=`echo $d | awk -F'|' '{print $1}'`
#DEL_LOCAL_FROM_DB=`echo $d | awk -F'|' '{print $2}'`
#ACCESS_POP3_FROM_DB=`echo $d | awk -F'|' '{print $3}'`
#ACCESS_RECEIVE_FROM_DB=`echo $d | awk -F'|' '{print $4}'`
#AUTO_ENABLED_FROM_DB=`echo $d | awk -F'|' '{print $5}'`
#FORWARD_TO_FROM_DB=`echo $d | awk -F'|' '{print $6}'`
#AUTO_MESSAGE_FROM_DB=`echo $d | awk -F'|' '{print $7}'`

done

#echo $PASS_FROM_DB
#echo $DEL_LOCAL_FROM_DB
#echo $ACCESS_POP3_FROM_DB
#echo $ACCESS_RECEIVE_FROM_DB
#echo $AUTO_ENABLED_FROM_DB
#echo $AUTO_MESSAGE_FROM_DB
#echo $FORWARD_TO_FROM_DB
#done
#echo $USER_INFO_FROM_DB

#PASS_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT VOPPASS FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`


#FORWARD_TO_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT FORWARD_TO FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`


#DEL_LOCAL_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT DEL_LOCAL FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`


#AUTO_ENABLED_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT AUTO_ENABLED FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`


#ACCESS_POP3_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT ACCESS_POP3 FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`


#ACCESS_RECEIVE_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT ACCESS_RECEIVE FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`


#AUTO_MESSAGE_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT AUTO_MESSAGE FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`

#AUTO_MESSAGE_PROCESSED=`echo $AUTO_MESSAGE_FROM_DB | sed ':a;N;$!ba;s/\n/{BREAK}/g'`

#AUTO_MESSAGE_PROCESSED=`echo -n $AUTO_MESSAGE_FROM_DB | sed 's/{SPACE}/ /g'`


#MAILBOX_DIRECTORY_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT MAILBOX_DIRECTORY FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci"`

#echo $CRAPMAILUSER


echo "$CRAPMAILUSER|$PASS_FROM_DB|$ALTUSER1|$ALTUSER2|$ALTUSER3|$ALTUSER4|$FORWARD_TO_FROM_DB|$DEL_LOCAL_FROM_DB|$ACCESS_POP3_FROM_DB|$ACCESS_RECEIVE_FROM_DB|$AUTO_ENABLED_FROM_DB|$AUTO_MESSAGE_FROM_DB|" 


#>> flatout1.csv
#$MAILBOX_DIRECTORY_FROM_DB"

done

#done