# check_service_server

Sono una serie di script che partono in sequenza per monitorare il corretto funzionamenti dei servizi dei server

requisiti:

- devono essere server linux
- tutti i server devono avere una share condivisa in comune (vedi nfs)
- in questo caso viene utilizzato una componente della suite di SAS per l'invio mail (in alternativa bisogna configurare un server mail, vedi uno script di esempio nel file sendmail_esempio.txt)




Sequenza e spiegazione script:

1) /nfs_share/script/monitoring/check_server.sh ---> deve essere eseguito da ogni macchina ---> fa lo status dei servizi di ogni macchina

2) /nfs_share/script/monitoring/esito_check_server.sh ---> deve essere eseguito da una sola macchina ---> stampa l'esito su un file di testo con OK o KO dello status dei servizi

3) /nfs_share/script/monitoring/check_server_KO.sh ---> check sul file stampato dallo script esito_check_server.sh 

{

 *** se i servizi sono OK poi il file di esito lo sposta in /nfs_share/output_monitoring/esiti_check/ senza richiamare lo script per l'invio mail

 
 *** se i servizi sono KO esegue lo script di invio mail che ci invia il file e poi lo sposta in /nfs_share/output_monitoring/sent

}

- /nfs_share/script/monitoring/invio_mail_check_FM.sh ---> viene richiamato da check_server_KO.sh se trova nell'esito un KO 

- /nfs_share/script/monitoring/invio_mail_check_FM.sas ---> script configurazione mail

- /nfs_share/script/monitoring/svecchiamento_file_check.sh ---> svecchiamento file check,  lascia in questo caso 3 giorni di retention



PS. per la schedulazione degli script io ho fatto un qualcosa del genere per fare un check del servizio ogni 5 minuti, ho fatto così in modo che non si sovrapponessero e creare così problemi

crontab script:

- 0,5,10,15,20,25,30,35,40,45,50,55 * * * * /nfs_share/script/monitoring/check_server.sh
- 2,7,12,17,22,27,32,37,42,47,52,57 * * * * /nfs_share/script/monitoring/esito_check_server.sh
- 4,9,14,19,24,29,34,39,44,49,54,59 * * * * /nfs_share/script/monitoring/check_server_KO.sh 



******** esempio: se imposti crontab */7 * * * * (ogni 7 minuti) e sono le 10:23 la prima esecuzione sarà alle 10:28:

10:07 ---> 10:14 ---> 10:21 ---> 10:28 ---> 10:35 ecc ecc

crontab anche se viene schedulato alle 10:23 si setta a partire dalle 10:07 
quindi non verrà eseguito dall'ora di inserimento in crontab ma seguirà la logica sopra
