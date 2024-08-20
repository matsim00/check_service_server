#!/bin/bash

#SVECCHIAMENTO CHECK FILE

#Specifica la retention in giorni(verranno cancellati i file di n° giorni prima)
range_date="5"

dir1="/nfs_share/output_monitoring/"

find $dir1 -type f  -daystart -mtime +$range_date -exec rm -f "{}" \;



##### AGGIUNGI SE NECESSARIO ULTERIORI VARIABILI CON IL PATH
