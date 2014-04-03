CSV_IN="maildir-list.csv"
CSV_OUT="duplicate-account-check-out-2.csv"
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

DOMAIN10=`echo $q | cut -d \| -f 38`

USERNAME11=`echo $q | cut -d \| -f 41`

DOMAIN11=`echo $q | cut -d \| -f 42`

USERNAME12=`echo $q | cut -d \| -f 45`

DOMAIN12=`echo $q | cut -d \| -f 46`

USERNAME13=`echo $q | cut -d \| -f 49`

DOMAIN13=`echo $q | cut -d \| -f 50`

USERNAME14=`echo $q | cut -d \| -f 53`

DOMAIN14=`echo $q | cut -d \| -f 54`

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
        	ADDRESS3=""
	        ADDRESS4=""
        	ADDRESS5=""
	        ADDRESS6=""
	        ADDRESS7=""
                ADDRESS8=""     
                ADDRESS9=""
                ADDRESS10=""
                ADDRESS11=""
                ADDRESS12=""
                ADDRESS13=""
                ADDRESS14=""
                
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

                        	                if [[ "$DOMAIN8" != "" ]]; then
						      ADDRESS8=$USERNAME8"@"$DOMAIN8

						      if [[ "$DOMAIN9" != "" ]]; then
							    ADDRESS9=$USERNAME9"@"$DOMAIN9

							    if [[ "$DOMAIN10" != "" ]]; then
								ADDRESS10=$USERNAME10"@"$DOMAIN10

								if [[ "$DOMAIN11" != "" ]]; then
								      ADDRESS11=$USERNAME11"@"$DOMAIN11

								      if [[ "$DOMAIN12" != "" ]]; then
									  ADDRESS12=$USERNAME12"@"$DOMAIN12

									    if [[ "$DOMAIN13" != "" ]]; then
										ADDRESS13=$USERNAME13"@"$DOMAIN13

									      if [[ "$DOMAIN14" != "" ]]; then
										  ADDRESS14=$USERNAME14"@"$DOMAIN14

										  else
										      :
										  fi
									    else
										:
									    fi
								      else
									  :
								      fi
								else
								    :
								fi
								
							    else
								:
							    fi
						      
						      else
							  :
						      fi
						      
						else
						    :
						fi
                        	                
                	                else
					  :	
       		                        fi
	                        else
					   :
	                        fi
        	        else
				  :
	                fi
        	else
			    :
	        fi
	else
		    :
	fi
else
	    :
fi


#		if [[ "$ADDRESS2" == "" ]]; then
	
			#"Single user - WOOHOO!"
			#DOMAIN=$DOMAIN1
#			echo $ADDRESS1
#			echo "$DEL_LOCAL|OK|$DOMAIN1|$ADDRESS1" >> "$CSV_OUT"
	
#		else
	
		if [[ "$DOMAIN1" == "$DOMAIN2" ]] || [[ "$DOMAIN2" == "" ]] ; then
				DOMAIN=$DOMAIN1	
			if [[ "$DOMAIN2" == "$DOMAIN3" ]] || [[ "$DOMAIN3" == "" ]]; then
				DOMAIN=$DOMAIN1
				if [[ "$DOMAIN3" == "$DOMAIN4" ]] || [[ "$DOMAIN4" == "" ]]; then
					DOMAIN=$DOMAIN1
					if [[ "$DOMAIN4" == "$DOMAIN5" ]] || [[ "$DOMAIN5" == "" ]]; then
						DOMAIN=$DOMAIN1
						if [[ "$DOMAIN5" == "$DOMAIN6" ]] || [[ "$DOMAIN6" == "" ]]; then
							DOMAIN=$DOMAIN1
   
							if [[ "$DOMAIN6" == "$DOMAIN7" ]] || [[ "$DOMAIN7" == "" ]]; then
								DOMAIN=$DOMAIN1			
								
								if [[ "$DOMAIN7" == "$DOMAIN8" ]] || [[ "$DOMAIN8" == "" ]]; then
								      DOMAIN=$DOMAIN1		
								      
								      if [[ "$DOMAIN8" == "$DOMAIN9" ]] || [[ "$DOMAIN9" == "" ]]; then
									    DOMAIN=$DOMAIN1
									    
									if [[ "$DOMAIN9" == "$DOMAIN10" ]] || [[ "$DOMAIN10" == "" ]]; then
										  DOMAIN=$DOMAIN1	
										  
										  if [[ "$DOMAIN10" == "$DOMAIN11" ]] || [[ "$DOMAIN11" == "" ]]; then
											DOMAIN=$DOMAIN1
											
											if [[ "$DOMAIN11" == "$DOMAIN12" ]] || [[ "$DOMAIN12" == "" ]]; then
											      DOMAIN=$DOMAIN1	
											      
												if [[ "$DOMAIN12" == "$DOMAIN13" ]] || [[ "$DOMAIN13" == "" ]]; then
												      DOMAIN=$DOMAIN1	
												      
													if [[ "$DOMAIN13" == "$DOMAIN14" ]] || [[ "$DOMAIN14" == "" ]]; then
												     		 DOMAIN=$DOMAIN1						
													else
										 	 		    DOMAIN=$DEFAULT_DOMAIN
										 			fi
												else
										 	 	    DOMAIN=$DEFAULT_DOMAIN
										 		fi
											else
										 	     DOMAIN=$DEFAULT_DOMAIN
										 	fi
										  else
										      DOMAIN=$DEFAULT_DOMAIN
										  fi
									 else
										DOMAIN=$DEFAULT_DOMAIN
									 fi
								      else
									  DOMAIN=$DEFAULT_DOMAIN
								      fi
								 
								else
								      DOMAIN=$DEFAULT_DOMAIN
								 fi									
								
							else
								DOMAIN=$DEFAULT_DOMAIN								
							fi
   
						else								
							  DOMAIN=$DEFAULT_DOMAIN		
						fi
					else								
						 DOMAIN=$DEFAULT_DOMAIN						
					fi
				else							
					  DOMAIN=$DEFAULT_DOMAIN										
				fi
			else								
				  DOMAIN=$DEFAULT_DOMAIN
			fi
		else
			DOMAIN=$DEFAULT_DOMAIN
		fi
			
#			
#		DOMAIN=$DEFAULT_DOMAIN
#		fi	
		
		if [[ "$DOMAIN" == "$DEFAULT_DOMAIN" ]]; then
	                        echo $ADDRESS1
	                        echo "$DEL_LOCAL|PROBLEM|$DOMAIN|$ADDRESS1|$ADDRESS2|$ADDRESS3|$ADDRESS4|$ADDRESS5|$ADDRESS6|$ADDRESS7|$ADDRESS8|$ADDRESS9|$ADDRESS10|$ADDRESS11|$ADDRESS12|$ADDRESS13|$ADDRESS14" >> "$CSV_OUT"

			else
	                        echo $ADDRESS1
                                echo "$DEL_LOCAL|OK|$DOMAIN|$ADDRESS1|$ADDRESS2|$ADDRESS3|$ADDRESS4|$ADDRESS5|$ADDRESS6|$ADDRESS7|$ADDRESS8|$ADDRESS9|$ADDRESS10|$ADDRESS11|$ADDRESS12|$ADDRESS13|$ADDRESS14" >> "$CSV_OUT"
#"$DOMAIN"|"$ADDRESS1"|"$ADDRESS2"|"$ADDRESS3"|"$ADDRESS4"|"$ADDRESS5"|"$ADDRESS6"|"$ADDRESS7" >> "$CSV_OUT

				
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

