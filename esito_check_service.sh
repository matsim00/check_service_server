#!/bin/bash


data=$(date +%Y%m%d%H)
datah=$(date +%Y%m%d%H%M)

pathFiles="/nfs_share/output_monitoring/minute_check"
pathFilesServer="/nfs_share/output_monitoring/minute_check/server"
check="/nfs_share/output_monitoring/check_server_"$datah".txt"

server=("$pathFiles"/server1_*.txt "$pathFiles"/server2_*.txt "$pathFiles"/server3_*.txt)
service_down="not running"


####CHECK FILE ESITO CHECK#######
if [ -e "$check" ]; then
	rm -f /nfs_share/output_monitoring/check_server_*
	echo "------ ESITO CHECK $datah----- " >> "$check"
else
	echo "------ ESITO CHECK $datah----- " >> "$check"
	chmod 664 $check
fi

###CHECK SERVER###
for elemento in "${server[@]}"; do
if [ -e "$elemento" ]; then
    if grep -i "$service_down" "$elemento"; then
        echo "SERVER $(basename "$elemento" .txt | awk -F '_' '{print toupper($1)}') KO:"  >> "$check"
        grep -i "$service_down" "$elemento" >> "$check"
echo "----------------------------------------------" >> "$check"  		
		else	
		echo "SERVER $(basename "$elemento" .txt | awk -F '_' '{print toupper($1)}') - OK" >> "$check"
echo "----------------------------------------------" >> "$check"  		
    fi	
else 
echo "Non sono presenti file di monitoraggio di server" >> "$check"
echo "----------------------------------------------" >> "$check"
fi
done

mv "${server[@]}" $pathFilesServer
