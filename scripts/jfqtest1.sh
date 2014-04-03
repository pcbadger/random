CSV_IN="crapmailusernames.csv"
DBUSER="root"
DBPASS="###REDACTEDPASSWORD###"
DBNAME="vmail"
TABLEIN="vmail"


for u in `cat ${CSV_IN}`


do

CRAPMAILUSER=`echo $u | awk -F, '{print $1}'`

USER_DOMAIN_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT USERNAME , DOMAIN FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN != CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`

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


done

if [ X"$ALTUSER2" == X"@" ]; then
	ALTUSER2=""
	ALTUSER3=""
	ALTUSER4=""
elif [ X"$ALTUSER3" == X"@" ]; then
        ALTUSER3=""
        ALTUSER4=""
elif [ X"$ALTUSER3" == X"@" ]; then
        ALTUSER4=""

else
	:
fi

PASS_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT VOPPASS FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`


FORWARD_TO_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT FORWARD_TO FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`



DEL_LOCAL_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT DEL_LOCAL FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`


AUTO_ENABLED_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT AUTO_ENABLED FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`


ACCESS_POP3_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT ACCESS_POP3 FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`


ACCESS_RECEIVE_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT ACCESS_RECEIVE FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`


AUTO_MESSAGE_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT AUTO_MESSAGE FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '%"$CRAPMAILUSER"%' USING latin1 ) COLLATE latin1_swedish_ci"`


echo "$CRAPMAILUSER|$PASS_FROM_DB|$ALTUSER1|$ALTUSER2|$ALTUSER3|$ALTUSER4|$FORWARD_TO_FROM_DB|$DEL_LOCAL_FROM_DB|$ACCESS_POP3_FROM_DB|$ACCESS_RECEIVE_FROM_DB|$AUTO_ENABLED_FROM_DB|$AUTO_MESSAGE_FROM_DB"



done
