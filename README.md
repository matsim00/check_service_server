# check_service_server

Sono una serie di script che partono in sequenza per monitorare il corretto funzionamenti dei servizi dei server

requisiti:

- devono essere server linux
- tutti i server devono avere una share condivisa in comune (vedi nfs)
- in questo caso viene utilizzato una componente della suite di SAS per l'invio mail (in alternativa bisogna configurare un server mail, vedi uno script di esempio nel file sendmail_esempio.txt)



Sequenza e spiegazione script:

- /nfs_share/script/monitoring/check_server.sh ---> deve essere eseguito da ogni macchina ---> fa lo status dei servizi di ogni macchina

- /nfs_share/script/monitoring/esito_check_server.sh ---> deve essere eseguito da una sola macchina ---> stampa l'esito su un file di testo con OK o KO dello status dei servizi

- /nfs_share/script/monitoring/check_server_KO.sh ---> check sul file stampato dallo script esito_check_server.sh 

                            *** se i servizi sono OK poi il file di esito lo sposta in /nfs_share/output_monitoring/esiti_check/
                              senza richiamare lo script per l'invio mail
                            *** se i servizi sono KO esegue lo script di invio mail che ci invia il file e poi lo sposta in
                              /nfs_share/output_monitoring/sent

- /nfs_share/script/monitoring/invio_mail_check_FM.sh ---> viene richiamato da check_server_KO.sh se trova nell'esito un KO 

- /nfs_share/script/monitoring/invio_mail_check_FM.sas ---> script configurazione mail

- /nfs_share/script/monitoring/svecchiamento_file_check.sh ---> svecchiamento file check,  lascia 1 giorno di retention
