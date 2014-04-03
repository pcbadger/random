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

USER_DOMAIN_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -s -N -e "SELECT USERNAME, DOMAIN FROM "$DBNAME"."$TABLEIN" WHERE MAILBOX_DIRECTORY = CONVERT( _utf8 '$MAILDIR' USING latin1 ) AND DOMAIN != CONVERT( _utf8 '' USING latin1 ) COLLATE latin1_swedish_ci" | sed 's/ /|/g' | sed 's/\*/STAR/g'`

USER_DOMAIN_LIST=$(echo $USER_DOMAIN_FROM_DB | sed 's/\*/STAR/g')

#| sed 's/ /|/g' 
#echo ${#USER_DOMAIN_LIST[@]}



declare -a arraylist=($USER_DOMAIN_LIST)

echo ${arraylist[@]}
echo ${#arraylist[@]}

#ADDRESS1=$USERNAME1"@"$DOMAIN1
#        	ADDRESS3=""
#	        ADDRESS4=""
#        	ADDRESS5=""
#	        ADDRESS6=""
#	        ADDRESS7=""
 #               ADDRESS8=""     
  #              ADDRESS9=""
   #             ADDRESS10=""
    #            ADDRESS11=""
     #           ADDRESS12=""
      #          ADDRESS13=""
       #         ADDRESS14=""
                
((n_arraylist=${#arraylist[@]}, max_index=n_arraylist - 1))
for ((i = 0; i <= max_index; i++;));

do     
DOMAININT=$(($i + 1))
echo "domint" $DOMAININT
DOMAINI=`echo $arraylist | cut -d " " -f $DOMAININT `

echo "Domain $i: '${DOMAINI}'"


#  echo "Element $i: '${USER_DOMAIN_LIST[i]}'"

#DOMAINCOUNTER="\$DOMAIN"$COUNT
#ADDRESSCOUNTER=`echo \$ADDRESS$COUNT`
#USERNAMECOUNTER=`echo \$USERNAME$COUNT`
#echo "domain 1 $DOMAIN1"
#echo "domain" $DOMAINCOUNTER
#echo "username $USERNAMECOUNTER"
#echo "domain $DOMAINCOUNT"

if [[ "$DOMAINCOUNTER" != "" ]]; then
	ADDRESSCOUNTER=$USERNAMECOUNTER"@"$DOMAINCOUNTER
#echo "count $ADDRESSCOUNTER"
else
  :
fi

done

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
:
#	                        echo $ADDRESS1
#	                        echo "$DEL_LOCAL|PROBLEM|$DOMAIN|$ADDRESS1|$ADDRESS2|$ADDRESS3|$ADDRESS4|$ADDRESS5|$ADDRESS6|$ADDRESS7|$ADDRESS8|$ADDRESS9|$ADDRESS10|$ADDRESS11|$ADDRESS12|$ADDRESS13|$ADDRESS14" >> "$CSV_OUT"

			else
			:
			#	                        echo $ADDRESS1
 #                               echo "$DEL_LOCAL|OK|$DOMAIN|$ADDRESS1|$ADDRESS2|$ADDRESS3|$ADDRESS4|$ADDRESS5|$ADDRESS6|$ADDRESS7|$ADDRESS8|$ADDRESS9|$ADDRESS10|$ADDRESS11|$ADDRESS12|$ADDRESS13|$ADDRESS14" >> "$CSV_OUT"
#"$DOMAIN"|"$ADDRESS1"|"$ADDRESS2"|"$ADDRESS3"|"$ADDRESS4"|"$ADDRESS5"|"$ADDRESS6"|"$ADDRESS7" >> "$CSV_OUT

				
		fi





#USER_INFO_FROM_DB=`mysql -u"$DBUSER" -p"$DBPASS" -N -e "SELECT VOPPASS, DEL_LOCAL, ACCESS_POP3, ACCESS_RECEIVE, AUTO_ENABLED, FORWARD_TO, AUTO_MESSAGE FROM "$DBNAME"."$TABLEIN" WHERE DOMAIN = CONVERT( _utf8 ' 'USING latin1 ) AND MAILBOX_DIRECTORY LIKE CONVERT( _utf8 '"$MAILDIR"' USING latin1 ) COLLATE latin1_swedish_ci" | sed 's/\t/|/g' | sed 's/ /{SPACE}/g'`

#for d in $USER_INFO_FROM_DB

#do


#PASS_FROM_DB=`echo $d | cut -d " " -d'|' -f 1`
#DEL_LOCAL_FROM_DB=`echo $d | cut -d " " -d'|' -f 2`
#ACCESS_POP3_FROM_DB=`echo $d | cut -d " " -d'|' -f 3`
#ACCESS_RECEIVE_FROM_DB=`echo $d | cut -d " " -d'|' -f 4`
#AUTO_ENABLED_FROM_DB=`echo $d | cut -d " " -d'|' -f 5`
#FORWARD_TO_FROM_DB=`echo $d | cut -d " " -d'|' -f 6`
#AUTO_MESSAGE_FROM_DB=`echo $d | cut -d " " -d'|' -f 7`

#done

#PASS_PROCESSED=`echo $PASS_FROM_DB | sed 's/|/{PIPE}/g'`

#echo $CRAPMAILUSER
#echo "$CRAPMAILUSER|$PASS_PROCESSED|$ALTUSER1|$ALTUSER2|$ALTUSER3|$ALTUSER4|$ALTUSER5|$ALTUSER6|$FORWARD_TO_FROM_DB|$DEL_LOCAL_FROM_DB|$ACCESS_POP3_FROM_DB|$ACCESS_RECEIVE_FROM_DB|$AUTO_ENABLED_FROM_DB|$AUTO_MESSAGE_FROM_DB|" >> "$CSV_OUT"

done

