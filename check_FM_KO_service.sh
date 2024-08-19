#!/bin/bash

DIR="/nfs_share/output_monitoring/check_server_*"


if grep "KO" $DIR; then
 #se trova un KO nell'ultimo file generato fa partire lo script di invio mail
        /nfs_share/invio_mail_check_server.sh
else
        echo "NON CI SONO SERVIZI KO"
        mv $DIR /nfs_share/output_monitoring/esiti_check/
fi
