#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)

for i in $(ls *.nmap);do

if [ $i='*.nmap' ] ; then

printf "Processing ${bold}$i${normal}\n";

WC="$(wc -l $i)"
arr=($WC)
printf "${bold}${arr[0]}${normal} raw ${bold}nmap${normal} lines captured\n";
printf "Processing raw IP addresses in ${bold}$i${normal}\n";

grep -E -o "(25[0-5]|2[0-4][0-9]|[01][0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" $i > $i.ips
WCI="$(wc -l $i.ips)"
arri=($WCI)
printf ${bold}${arri[0]}${normal}" total IP addresses found\n";

PWC="$(wc -l $i.nodupes)"
pwca=($PWC);
printf "Removing duplicate IP addresses\n";
`awk '!seen[$0]++' $i.ips > $i.nodupes`
WCD="$(wc -l $i.nodupes)"
arrd=($WCD)
nethosts=$((${arrd[0]}-${pwca}));
printf "${nethosts} new hosts. ${bold}${arrd[0]}${normal} vulnerable hosts. Saved to $i.nodupes\n\n";
rm $i.ips

#echo -e "View list (Y/n)? \c" 
#read resp

#if [ "$resp" != "n" ] ; then
#more="$(more $i.nodupes)"
#echo "$more"
#else
#echo "Happy hacking."
#fi

else

echo "$@ doesn't exist. Try something with a .nmap extension"
fi

done
#sudo tsocks proxychains nmap -vvv -Pn -sS -p 80 -iR 0 --open | tee -a port80.nmap

