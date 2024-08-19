#!/bin/bash
source $HOME/.bash_profile

PathMon="/nfs_share/output_monitoring/"
PathMet="/sas/software/"
data=$(date +%Y%m%d%H%M)

cd $PathMon

if [ check_server_* ] ; then
    $PathMet/SASFoundation/9.4/sasexe/sas -sysin $PathHome/invio_mail_check_server.sas -log /nfs_share/output_monitoring/logs/invio_mail_check_server_$data.log
        mv check_server_* $PathMon/sent/
else
        echo "check_server_* non trovato, invio non effettuato"
fi
