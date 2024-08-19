options emailsys=smtp emailhost=nome_dns_server_smtp emailport=25;
        FILENAME outmail EMAIL ;
         data _null_;
        FILE outmail    TO=('mail1')
                                        CC=('mail2' 'mail3')
        attach="/nfs_share/output_monitoring/esito_*.txt"
                SUBJECT="Invio giornaliero Esito Check Server"  CT = "TEXT/HTML" debug;
                a=getoption('log');
        file outmail;
        put "Salve";
        put "<br> In allegato il file dell'esito dei check dei server";
        put "<br> Saluti";
run;
