CSV_IN="maildir-list.csv"
CSV_OUT="duplicate-account-check-out-1.csv"
DBUSER="root"
DBPASS="###REDACTEDPASSWORD###"
DBNAME="vmail"
TABLEIN="vmail"
DEFAULT_DOMAIN="clientinterwebs.com"


for u in `cat ${CSV_IN}`

do

MAILDIR=`echo $u | awk -F, '{print $1}'`

#echo "Maildir: $MAILDIR"

CRAPMAILUSER=`echo $MAILDIR | sed 's/.*\\\//'`

USER_DOMAIN_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT USERNAME, DOMAIN, DEL_LOCAL, HOME_WEB  FROM "$DBNAME"."$TABLEIN" WHERE MAILBOX_DIRECTORY = CONVERT( _utf8 '$MAILDIR' USING latin1 ) AND DOMAIN != CONVERT( _utf8 '' USING latin1 ) COLLATE latin1_swedish_ci" | sed 's/ /|/g' | sed 's/\*/STAR/g'`

USER_DOMAIN_LIST=$(echo $USER_DOMAIN_FROM_DB | sed 's/ /|/g' | sed 's/\*/STAR/g')
# | sed 's/}\+/\n/g')

#echo $USER_DOMAIN_LIST 

for q in $USER_DOMAIN_LIST
#
do

USERNAME1=`echo $q | cut -d \| -f 1`

DOMAIN1=`echo $q | cut -d \| -f 2 `

DEL_LOCAL=`echo $q | cut -d \| -f 3`

USERNAME2=`echo $q | cut -d \| -f 5`

DOMAIN2=`echo $q | cut -d \| -f 6 `

USERNAME3=`echo $q | cut -d \| -f 9`

DOMAIN3=`echo $q | cut -d \| -f 10 `

USERNAME4=`echo $q | cut -d \| -f 13`

DOMAIN4=`echo $q | cut -d \| -f 14 `

USERNAME5=`echo $q | cut -d \| -f 17`

DOMAIN5=`echo $q | cut -d \| -f 18 `

USERNAME6=`echo $q | cut -d \| -f 21`

DOMAIN6=`echo $q | cut -d \| -f 22`

USERNAME7=`echo $q | cut -d \| -f 25`

DOMAIN7=`echo $q | cut -d \| -f 26`

USERNAME8=`echo $q | cut -d \| -f 29`

DOMAIN8=`echo $q | cut -d \| -f 30`

USERNAME9=`echo $q | cut -d \| -f 33`

DOMAIN9=`echo $q | cut -d \| -f 34`

USERNAME10=`echo $q | cut -d \| -f 37`

DOMAIN10=`echo $q | cut -d \| -f 37`

USERNAME11=`echo $q | cut -d \| -f 40`

DOMAIN11=`echo $q | cut -d \| -f 40`


#USERNAME2=`echo $q | awk -F"|" '{print $5}'`

#DOMAIN2=`echo $q | awk -F\| '{print $6}'`

#USERNAME3=`echo $q | awk -F\| '{print $9}'`

#DOMAIN3=`echo $q | awk -F\| '{print $10}'`

#USERNAME4=`echo $q | awk -F\| '{print $13}'`

#DOMAIN4=`echo $q | awk -F\| '{print $14}'`

#USERNAME5=`echo $q | awk -F\| '{print $17}'`

#DOMAIN5=`echo $q | awk -F\| '{print $18}'`

#USERNAME6=`echo $q | awk -F\| '{print $21}'`

#DOMAIN6=`echo $q | awk -F\| '{print $22}'`

#USERNAME7=`echo $q | awk -F\| '{print $25}'`

#DOMAIN7=`echo $q | awk -F\| '{print $26}'`


#echo "filt:" $USERNAME1 $DOMAIN1 $USERNAME2 $DOMAIN2 $USERNAME3 $DOMAIN3 $USERNAME4 $DOMAIN4

#ACCESS_POP3=`echo $q | awk -F, '{print $4}'`

#ACCESS_RECEIVE=`echo $q | awk -F, '{print $5}'`

#AUTO_ENABLED=`echo $q | awk -F, '{print $6}'`

#MAILBOX_DIRECTORY=`echo $q | awk -F, '{print $7}'`

done

ADDRESS1=$USERNAME1"@"$DOMAIN1
if [[ "$DOMAIN2" != "" ]]; then
	ADDRESS2=$USERNAME2"@"$DOMAIN2
	
	if [[ "$DOMAIN3" != "" ]]; then
        	ADDRESS3=$USERNAME3"@"$DOMAIN3

	        if [[ "$DOMAIN4" != "" ]]; then
	                ADDRESS4=$USERNAME4"@"$DOMAIN4
		
		        if [[ "$DOMAIN5" != "" ]]; then
                	        ADDRESS5=$USERNAME5"@"$DOMAIN5

                	        if [[ "$DOMAIN6" != "" ]]; then
        	                        ADDRESS6=$USERNAME6"@"$DOMAIN6
				
				        if [[ "$DOMAIN7" != "" ]]; then
                        	                ADDRESS7=$USERNAME7"@"$DOMAIN7

                	                else
        	                                ADDRESS7=""
						ADDRESS8=""
						ADDRESS9=""
						ADDRESS10=""
						ADDRESS11=""	
       		                        fi
	

	                        else
                	                ADDRESS6=""
        	                        ADDRESS7=""
                                        ADDRESS8=""     
                                        ADDRESS9=""
                                        ADDRESS10=""
                                        ADDRESS11=""
	
	                        fi



        	        else
                	        ADDRESS5=""
                        	ADDRESS6=""
        	                ADDRESS7=""
                                ADDRESS8=""     
                                ADDRESS9=""
                                ADDRESS10=""
                                ADDRESS11=""

	                fi



        	else
	                ADDRESS4=""
	                ADDRESS5=""
                	ADDRESS6=""
        	        ADDRESS7=""
                                                ADDRESS8=""     
                                                ADDRESS9=""
                                                ADDRESS10=""
                                                ADDRESS11=""

	        fi



	else
        	ADDRESS3=""
	        ADDRESS4=""
        	ADDRESS5=""
	        ADDRESS6=""
	        ADDRESS7=""
                ADDRESS8=""     
                ADDRESS9=""
                ADDRESS10=""
                ADDRESS11=""

	fi

else
	ADDRESS2=""
	ADDRESS3=""
	ADDRESS4=""
	ADDRESS5=""
	ADDRESS6=""
	ADDRESS7=""

fi


		if [ "$ADDRESS2" = "" ]; then
	
			#"Single user - WOOHOO!"
			#DOMAIN=$DOMAIN1
			echo $ADDRESS1
			echo "$DEL_LOCAL|OK|$DOMAIN1|$ADDRESS1" >> "$CSV_OUT"
	
		else
		
#			echo "MULTI user "
			if [ "$DOMAIN1" = "$DOMAIN2" ]; then
				
				if [ "$DOMAIN2" = "$DOMAIN3" ]; then
#					echo "3 users: 1,2,3 match"
					DOMAIN=$DOMAIN1

					if [ "$DOMAIN3" = "$DOMAIN4" ]; then
#						echo "4 users: 1,2,3,4 match"
						DOMAIN=$DOMAIN1

						if [ "$DOMAIN4" = "$DOMAIN5" ]; then
#							echo "5: 1,2,3,4,5 match"
							DOMAIN=$DOMAIN1

							if [ "$DOMAIN5" = "$DOMAIN6" ]; then
#								echo "6 users: 1,2,3,4,5,6 match"
								DOMAIN=$DOMAIN1
    
    								if [ "$DOMAIN6" = "$DOMAIN7" ]; then
									NUMBER="7"
#									echo "7 Users: all matching domains"
									DOMAIN=$DOMAIN1						
								else

									if [ "$DOMAIN7" = "" ]; then
									    NUMBER="6"
 #   									echo "6 Users: matching domains"
									    DOMAIN=$DOMAIN1						
									else
									    NUMBER="7"
#										echo "7 Users: mismatch!"
									    DOMAIN=$DEFAULT_DOMAIN
									fi
								
								fi
    
    
							else								
								if [ "$DOMAIN6" = "" ]; then
									NUMBER="5"
#									echo "5 Users: matching domains"
									DOMAIN=$DOMAIN1						
								else
									NUMBER="6"
#									echo "6 Users: mismatch!"
									DOMAIN=$DEFAULT_DOMAIN
								fi
							fi


						else								
							if [ "$DOMAIN5" = "" ]; then
								NUMBER="4"
#								echo "4 Users: matching domains"
								DOMAIN=$DOMAIN1						
							else
								NUMBER="5"
#								echo "5 Users: mismatch!"
								DOMAIN=$DEFAULT_DOMAIN
							fi
						fi


					else								
						if [ "$DOMAIN4" = "" ]; then
#							echo "3 Users: matching domains"
							DOMAIN=$DOMAIN1
						
						else
#							echo "4 Users: mismatch!"
							DOMAIN=$DEFAULT_DOMAIN
						fi
					fi
				else								
					if [ "$DOMAIN3" = "" ]; then
#						echo "2 Users: matching domains"
						DOMAIN=$DOMAIN1						
					else
#						echo "3 Users: mismatch!"
						DOMAIN=$DEFAULT_DOMAIN
					fi
				fi
			else
#				echo "MULTI DOMAIN - MISMATCH!"
				DOMAIN=$DEFAULT_DOMAIN
			fi
			
			if [[ "$DOMAIN" == "$DEFAULT_DOMAIN" ]]; then
	                        echo $ADDRESS1
	                        echo "$DEL_LOCAL|PROBLEM|$DOMAIN|$ADDRESS1|$ADDRESS2|$ADDRESS3|$ADDRESS4|$ADDRESS5|$ADDRESS6|$ADDRESS7" >> "$CSV_OUT"

			else
	                        echo $ADDRESS1
                                echo "$DEL_LOCAL|OK|$DOMAIN|$ADDRESS1|$ADDRESS2|$ADDRESS3|$ADDRESS4|$ADDRESS5|$ADDRESS6|$ADDRESS7" >> "$CSV_OUT"
#"$DOMAIN"|"$ADDRESS1"|"$ADDRESS2"|"$ADDRESS3"|"$ADDRESS4"|"$ADDRESS5"|"$ADDRESS6"|"$ADDRESS7" >> "$CSV_OUT

			fi	
		fi





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

