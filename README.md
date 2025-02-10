# check_service_server

Questo è un insieme di script che vengono eseguiti in sequenza per monitorare il corretto funzionamento dei servizi sui server.

## Requisiti

- I server devono essere **Linux**.
- Tutti i server devono avere una **share condivisa** in comune (ad esempio, tramite NFS).
- Lo script utilizza una componente della suite SAS per l'invio delle email. In alternativa, è necessario configurare un server di posta. Un esempio di configurazione è disponibile nel file `sendmail_esempio.txt`.

## Sequenza e spiegazione degli script

1. **`/nfs_share/script/monitoring/check_server.sh`**  
   - Deve essere eseguito su ogni macchina.  
   - Controlla lo stato dei servizi su ogni macchina.

2. **`/nfs_share/script/monitoring/esito_check_server.sh`**  
   - Deve essere eseguito su una sola macchina.  
   - Stampa l'esito (OK o KO) dello stato dei servizi in un file di testo.

3. **`/nfs_share/script/monitoring/check_server_KO.sh`**  
   - Esegue un controllo sul file prodotto dallo script `esito_check_server.sh`.  
   - **Se i servizi sono OK:**  
     - Sposta il file di esito in `/nfs_share/output_monitoring/esiti_check/` senza eseguire lo script di invio email.
   - **Se i servizi sono KO:**  
     - Esegue lo script di invio email, invia il file e poi lo sposta in `/nfs_share/output_monitoring/sent/`.

4. **`/nfs_share/script/monitoring/invio_mail_check_FM.sh`**  
   - Viene eseguito da `check_server_KO.sh` se trova "KO" nell'esito.

5. **`/nfs_share/script/monitoring/invio_mail_check_FM.sas`**  
   - Script di configurazione per l'invio delle email.

6. **`/nfs_share/script/monitoring/svecchiamento_file_check.sh`**  
   - Si occupa della gestione dei file di log, mantenendo solo gli ultimi 3 giorni di dati (retention).

## Programmazione tramite `crontab`

Per la schedulazione degli script, ho configurato i seguenti intervalli in modo da evitare sovrapposizioni e garantire un controllo regolare senza conflitti. Ecco come è stato impostato il `crontab`:

- 0,5,10,15,20,25,30,35,40,45,50,55 * * * * /nfs_share/script/monitoring/check_server.sh 
- 2,7,12,17,22,27,32,37,42,47,52,57 * * * * /nfs_share/script/monitoring/esito_check_server.sh 
- 4,9,14,19,24,29,34,39,44,49,54,59 * * * * /nfs_share/script/monitoring/check_server_KO.sh

### Esempio di funzionamento del `crontab`

Se imposti il `crontab` con un intervallo di */7 minuti (ogni 7 minuti), e l'ora corrente è 10:23, la prima esecuzione sarà alle 10:28, seguendo questo schema:

- 10:07 → 10:14 → 10:21 → 10:28 → 10:35 → ...

Anche se il `crontab` è schedulato alle 10:23, l'esecuzione inizierà dalle 10:07, seguendo sempre la logica dell'intervallo impostato.


