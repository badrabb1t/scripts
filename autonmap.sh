# Automates nmap scans for hosts on the specified network range
# Finds responding hosts, adds hostnames to /etc/hosts, makes directory for each, scans each with nmap 
#
# TODO: Option to disable modifying /etc/hosts
# TODO: Option to use IPs instead of DNS lookup
#
# @badrabb1t 2017

bold="\e[1m"
unbold="\e[0m"

printf "Warning! This script creates a directory for each responding host on the network in the current working dir. Make sure you are run this script from the directory in which you want your output.\n\nWhat is the target network range? "
read netrange

# find responding hosts
# output iplist.txt
printf "Finding responding hosts...\n"
nmap -n -sn $netrange | grep report | cut -d " " -f5 > iplist.txt
n=$(cat iplist.txt | wc -l)
printf "$bold$n responses received.$unbold\n\n"

# find DNS servers, output to nameservers.txt
printf "Finding DNS servers...\n"
nameservers=$(nmap -iL iplist.txt -Pn -n -p 53 --open | grep report | cut -d " " -f5)
for i in $nameservers; do
  printf "$bold$i$unbold\n"
  echo $i >> nameservers.txt
done

# get FQDN for all responding hosts, add to /etc/hosts file
# creates hostlist.txt, list of IPs with hostnames 
touch fqdn-list.txt
printf "\nResolving FQDN for each responding host...\n"
while read p; do
  a=$(nslookup $p $i | grep name | cut -d ' ' -f3 | rev | cut -c 2- | rev)
  charcount=$(echo $a | wc -c)
#  printf "$charcount\n"
  if [ $charcount -gt 1 ]; then
    echo $a >> fqdn-list.txt
    echo $p - $a >> hostlist.txt
    printf "$p	$a\n" >> /etc/hosts
  fi

  # if the line we just wrote didnt include a hostname, remove it
  lastline=$(tac /etc/hosts | egrep -m 1 \. | wc -c)
  if [ $lastline -lt 19 ]; then
    sed -i '$ d' /etc/hosts
  fi
done <iplist.txt
# : << 'END'

# make a directory for each host
# output full nmap scan for each to its respective dir
printf "\nInitiating scan for each host...\n"
scancount=0
while read q; do
  mkdir $q
  nmap -sC -sV -n -v0 -Pn $q -p0-65535 -oA $q/nmap-tcp &
  scancount=$((scancount + 1))
done <fqdn-list.txt

printf "$bold$scancount scans running.$unbold\n"


printf "\nUse \'ps -e | grep nmap\' to check scan status.\n"

# Wait for scans to finish, then continue
b=$(ps -e | grep nmap | wc -l)
sleep 10
printf="There are <$b> scans currently running"
