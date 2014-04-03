INPUT="flatout2.csv"
STORAGE_BASE_DIRECTORY="/vmail1/crapmail"
MAILBOX_FORMAT=''
DEFAULT_QUOTA='100'
MAILDIR_STYLE='hashed'
STORAGE_BASE="$(dirname ${STORAGE_BASE_DIRECTORY})"
STORAGE_NODE="$(basename ${STORAGE_BASE_DIRECTORY})"
PAST='1969-07-21 02:56:00'
FUTURE='2363-09-27 12:00:00'
DEFAULT_DOMAIN="clientinterwebs.com"

for i in `cat ${INPUT}`

do

CRAPMAILNAME=`echo $i | cut -d \| -f 1`
DEFAULT_PASSWD=`echo $i | cut -d \| -f 2`
ALTUSER1_IN=`echo $i | cut -d \| -f 3`
ALTUSER2_IN=`echo $i | cut -d \| -f 4`
ALTUSER3_IN=`echo $i | cut -d \| -f 5`
ALTUSER4_IN=`echo $i | cut -d \| -f 6`
ALTUSER5_IN=`echo $i | cut -d \| -f 7`
ALTUSER6_IN=`echo $i | cut -d \| -f 8`
FORWARD_TO=`echo $i | cut -d \| -f 9`
DEL_LOCAL=`echo $i | cut -d \| -f 10`
ACCESS_POP3=`echo $i | cut -d \| -f 11`
ACCESS_RECEIVE=`echo $i | cut -d \| -f 12`
AUTO_ENABLED=`echo $i | cut -d \| -f 13`
AUTO_MESSAGE=`echo $i | cut -d \| -f 14`


ALTDOMAIN1=`echo $ALTUSER1_IN | sed 's/.*@//'`

ALTDOMAIN2=`echo $ALTUSER2_IN | sed 's/.*@//'`

ALTDOMAIN3=`echo $ALTUSER3_IN | sed 's/.*@//'`

ALTDOMAIN4=`echo $ALTUSER4_IN | sed 's/.*@//'`

ALTDOMAIN5=`echo $ALTUSER5_IN | sed 's/.*@//'`

ALTDOMAIN6=`echo $ALTUSER6_IN | sed 's/.*@//'`

DOMAIN_LIST=`echo $ALTDOMAIN1 $ALTDOMAIN2 $ALTDOMAIN3 $ALTDOMAIN4 $ALTDOMAIN5 $ALTDOMAIN6`

echo $DOMAIN_LIST

	if [[ $DOMAIN_LIST =~ .*clientinternet.* ]]; then

		if [ "$ALTUSER2_IN" = "" ]; then

			echo "Single user - clientinterwebs"
			DOMAIN=$DEFAULT_DOMAIN

		else

			echo "Multi user - including clientinternets"
			DOMAIN=$DEFAULT_DOMAIN
		fi

	else


		if [ "$ALTUSER2_IN" = "" ]; then
	
			echo "Single user - NOT clientinternets"
			DOMAIN=$ALTDOMAIN1

		else
		
			echo "MULTI user - NOT CLIENTINTERNETS"
			if [ "$ALTDOMAIN1" = "$ALTDOMAIN2" ]; then
				
				if [ "$ALTDOMAIN2" = "$ALTDOMAIN3" ]; then
					echo "3 users: 1,2,3 match"
					DOMAIN=$ALTDOMAIN1

					if [ "$ALTDOMAIN3" = "$ALTDOMAIN4" ]; then
						echo "4 users: 1,2,3,4 match"
						DOMAIN=$ALTDOMAIN1

						if [ "$ALTDOMAIN4" = "$ALTDOMAIN5" ]; then
							echo "5: 1,2,3,4,5 match"
							DOMAIN=$ALTDOMAIN1

							if [ "$ALTDOMAIN5" = "$ALTDOMAIN6" ]; then
								echo "6 users: 1,2,3,4,5,6 match"
								DOMAIN=$ALTDOMAIN1

							else								
								if [ "$ALTDOMAIN6" = "" ]; then
									echo "5 Users: matching domains"
									DOMAIN=$ALTDOMAIN1						
								else
									echo "6 Users: mismatch!"
									DOMAIN=$DEFAULT_DOMAIN
								fi
							fi


						else								
							if [ "$ALTDOMAIN5" = "" ]; then
								echo "4 Users: matching domains"
								DOMAIN=$ALTDOMAIN1						
							else
								echo "5 Users: mismatch!"
								DOMAIN=$DEFAULT_DOMAIN
							fi
						fi


					else								
						if [ "$ALTDOMAIN4" = "" ]; then
							echo "3 Users: matching domains"
							DOMAIN=$ALTDOMAIN1
						
						else
							echo "4 Users: mismatch!"
							DOMAIN=$DEFAULT_DOMAIN
						fi
					fi
				else								
					if [ "$ALTDOMAIN3" = "" ]; then
						echo "2 Users: matching domains"
						DOMAIN=$ALTDOMAIN1						
					else
						echo "3 Users: mismatch!"
						DOMAIN=$DEFAULT_DOMAIN
					fi
				fi
			else
				echo "MULTI DOMAIN - MISMATCH!"
				DOMAIN=$DEFAULT_DOMAIN
			fi
		fi
	fi





	if [ "$DOMAIN" = "$DEFAULT_DOMAIN" ]; then
		echo "Do all kinds of clientintertubes stuffs"					
	else
		echo "Carry On"
	fi



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
#echo 

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

#echo
#echo 


#echo "INSERT INTO mailbox (username, crapmailname, password, name, storagebasedirectory,storagenode, maildir, quota, domain, active, local_part, created)
#    VALUES ('${USERNAME}', '${CRAPMAILNAME}', '${CRYPT_PASSWD}', '${CRAPMAILNAME}', '${STORAGE_BASE}','${STORAGE_NODE}', '${maildir}', '${DEFAULT_QUOTA}', '${DOMAIN}', '1','${USERNAME}', NOW());

#INSERT INTO alias (address, goto, domain, created, active) VALUES ('${USERNAME}', '${FULL_FORWARD}','${DOMAIN}', NOW(), 1);

#INSERT INTO vacation (email, domain, startdate, enddate, subject, body, created, active) VALUES ('${USERNAME}','${DOMAIN}', ${PAST}, ${FUTURE}, Out Of Office, ${AUTO_MESSAGE}, NOW(), ${AUTO_ACTIVE});
#"

#echo "crapmailname: $CRAPMAILNAME"
#echo "domain: $DOMAIN"
#echo "username: $USERNAME"
#echo "passwd: $CRYPT_PASSWD"
#echo "maildir: $maildir"
#echo "forwards: $FULL_FORWARD"


echo "##END##"
done
#<file
