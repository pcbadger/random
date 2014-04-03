#$ cat domainchecker.sh
while read f1
do
echo -n "$f1" >> /tmp/domainchecker-out.txt
whois  "$f1" | grep -i 'NS1.COMPANY.NET\|ns1.d-o-m-a-i-n.net' >> /tmp/domainchecker-out.txt
echo "" >> /tmp/domainchecker-out.txt
done < dns-shutdown-sites.txt
