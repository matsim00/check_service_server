#!/bin/bash

#set -x

hname=$(hostname)
data=$(date +%Y%m%d%H%M)

pathSC="/nfs_share/script/monitoring"
pathOUT="/nfs/output_monitoring"
pathCHK="/nfs/output_monitoring/minute_check"


server1=$pathCHK"/server1_"$data".txt"
server2=$pathCHK"/server2_"$data".txt"
server3=$pathCHK"/server3_"$data".txt"



server()
{
	case "$hname" in
		
		server1 )
			echo " " >> $server1
        		echo "-----------------------------------------------------" >> $server1
        		echo "                 Stato server1" >> $server1
        		echo "-----------------------------------------------------" >> $server1
			systemctl status httpd.service >> $server1;
			;;
		
    server2 )
			echo " " >> $server2
                        echo "-----------------------------------------------------" >> $server2
                        echo "                 Stato server2" >> $server2
                        echo "-----------------------------------------------------" >> $server2
			systemctl status httpd.service >> $server2;
			;;
		
    server3 )
			echo " " >> $server3
                        echo "-----------------------------------------------------" >> $server3
                        echo "                 Stato server3" >> $server3
                        echo "-----------------------------------------------------" >> $server3
			systemctl status httpd.service >> $server3;
			;;
		*)
			echo "\n\tUsage: $0 [ Hostname non riconosciuto ]\n";
			exit 1 ;;
	esac
	
}



case "$hname" in

	server1 | server2 | server3 )
		server ;
		;;
	*)
        echo "\n\tUsage: $0 [ Hostname non riconosciuto ]\n";
        exit 1 ;;
esac
