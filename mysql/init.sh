result=$(mysql -s -N -uroot --password=idm -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='idm'"); 
if [ -z "$result" ]; 
then 
	mysql -s -N -uroot --password=idm -e "CREATE DATABASE idm";
	mysql -s -N -uroot --password=idm idm < /idm_backup.sql;
fi 