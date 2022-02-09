#!/bin/bash

#--------------------------------------------------------------------------------------------------------#

# # Written by Franklin on Sep 2021.
# # Basically, this script create a dump of source table,
# # and restore this dump to a destination table with a temporary name,
# # making a later rename on the target table and placing
# # the new information in production.

#--------------------------------------------------------------------------------------------------------#

#Global variables
#Adjust of mysql source database connection
MY_S_HOST="192.168.10.10"
MY_S_PORT="3306"
MY_S_DATABASE="dba_sample"
MY_S_USERNAME="user_sync"

#Adjust of mysql destination database connection
MY_D_HOST="127.0.0.1"
MY_D_PORT="3306"
MY_D_DATABASE="dba_sample"
MY_D_USERNAME="user_sync"

#Paths
PATH_DUMP="/home/routines/DBA_DUMP"
PATH_LOG="/home/routines/DBA_LOG"

#Environment variables
NAME_OPERATION="DBA"
TABLE_OPERATION="table-sample"
TABLE_TEMP_OPERATION="table-sample_temp"

#Logs variables
TYPE_OPERATION=""
STATUS_OPERATION=""
COUNT_SOURCE="1"
COUNT_DESTINATION="0"

#Monitoring
SERVER_FOR_ZABBIX_SENDER="xxx.xxx.xxx.xxx"
HOST_FOR_ZABBIX_SENDER="HOSTNAME_IN_TEMPLATE"
KEY_ITEM_FOR_ZABBIX_SENDER="dba.migration.database.sample.status"
VALUE_FOR_ZABBIX_SENDER=""

#--------------------------------------------------------------------------------------------------------#

#Primary function, this function has the responsibility to call other functions within the script. Everything starts here
run_main() {
  create_dump_mysql_source
  }

#--------------------------------------------------------------------------------------------------------#

#Function for create dump of table in mysql source.
create_dump_mysql_source() {
 
    mysqldump --no-create-db --no-create-info \
    -u "$MY_S_USERNAME" \
    -h "$MY_S_HOST" \
    -P "$MY_S_PORT" \
    "$MY_S_DATABASE" "$TABLE_OPERATION" > $PATH_DUMP/$NAME_OPERATION.$TABLE_OPERATION.sql

  if [[ -f "$PATH_DUMP/$NAME_OPERATION.$TABLE_OPERATION.sql" ]] && [[ -s "$PATH_DUMP/$NAME_OPERATION.$TABLE_OPERATION.sql" ]]; then
    TYPE_OPERATION="DUMP IN SOURCE"
    STATUS_OPERATION="SUCCESS"
    #$VALUE_FOR_ZABBIX_SENDER=0
    #zabbix_sender_status_dump_information
    generate_process_log
    restore_dump_mysql_destination
  else
    TYPE_OPERATION="DUMP IN SOURCE"
    STATUS_OPERATION="FAILURE"
    #$VALUE_FOR_ZABBIX_SENDER=1
    #zabbix_sender_status_dump_information
    generate_process_log
  fi

  }

#--------------------------------------------------------------------------------------------------------#

#Function for restore dump of table in mysql source.
restore_dump_mysql_destination() {

  MY_COMMAND_CREATE_TEMP="CREATE TABLE $TABLE_TEMP_OPERATION LIKE $TABLE_OPERATION;"
  MY_COMMAND_DROP_PRODUCTION="DROP TABLE $TABLE_OPERATION"
  MY_COMMAND_RENAME_TEMP="RENAME TABLE $TABLE_TEMP_OPERATION TO $TABLE_OPERATION;"
    #Create temp table with estructure of production table
    mysql \
    -u "$MY_D_USERNAME" \
    -h "$MY_D_HOST" \
    -D "$MY_D_DATABASE" \
    -P "$MY_D_PORT" \
    -e "$MY_COMMAND_CREATE_TEMP"

  adjust_archive_dump_information_with_sed

    #Restore dump in temp table
    mysql \
     -u "$MY_D_USERNAME" \
     -h "$MY_D_HOST" \
     -P "$MY_D_PORT" \
     "$MY_D_DATABASE" < $PATH_DUMP/$NAME_OPERATION.$TABLE_OPERATION.sql


    #Drop production table
    mysql \
    -u "$MY_D_USERNAME" \
    -h "$MY_D_HOST" \
    -D "$MY_D_DATABASE" \
    -P "$MY_D_PORT" \
    -e "$MY_COMMAND_DROP_PRODUCTION"

    #Rename temp table for production table
    mysql \
    -u "$MY_D_USERNAME" \
    -h "$MY_D_HOST" \
    -D "$MY_D_DATABASE" \
    -P "$MY_D_PORT" \
    -e "$MY_COMMAND_RENAME_TEMP"

  compare_databases_count_itens_post_restore

  if [[ "$COUNT_SOURCE" == "$COUNT_DESTINATION" ]]; then
    TYPE_OPERATION="RESTORE IN DESTINATION"
    STATUS_OPERATION="SUCCESS"
    #$VALUE_FOR_ZABBIX_SENDER=2
    #zabbix_sender_status_dump_information
    generate_process_log
  else
    TYPE_OPERATION="RESTORE IN DESTINATION"
    STATUS_OPERATION="FAILURE"
    #$VALUE_FOR_ZABBIX_SENDER=3
    #zabbix_sender_status_dump_information
    generate_process_log
  fi

  clean_process_archives_post_operation

  }

#--------------------------------------------------------------------------------------------------------#

generate_process_log() {

  echo "$(date +%d-%m-%Y-%H:%M:%S) : $TYPE_OPERATION -> $STATUS_OPERATION " >> $PATH_LOG/$NAME_OPERATION.$TABLE_OPERATION.log 
   
  }

#--------------------------------------------------------------------------------------------------------#

clean_process_archives_post_operation() {

  rm -Rf $PATH_DUMP/$NAME_OPERATION.$TABLE_OPERATION.sql

  }

#--------------------------------------------------------------------------------------------------------#

compare_databases_count_itens_post_restore() {

    MY_COMMAND_COUNT_SOURCE="SELECT COUNT(*) FROM $MY_S_DATABASE.$TABLE_OPERATION;"
    MY_COMMAND_COUNT_DESTINATION="SELECT COUNT(*) FROM $MY_D_DATABASE.$TABLE_OPERATION;"

    COUNT_SOURCE=$(mysql \
    -u "$MY_S_USERNAME" \
    -h "$MY_S_HOST" \
    -D "$MY_S_DATABASE" \
    -P "$MY_S_PORT" \
    -e "$MY_COMMAND_COUNT_SOURCE")

    COUNT_DESTINATION=$(mysql \
    -u "$MY_D_USERNAME" \
    -h "$MY_D_HOST" \
    -D "$MY_D_DATABASE" \
    -P "$MY_D_PORT" \
    -e "$MY_COMMAND_COUNT_DESTINATION")

  }

#--------------------------------------------------------------------------------------------------------#

adjust_archive_dump_information_with_sed(){

    sed -i '/LOCK/d' $PATH_DUMP/$NAME_OPERATION.$TABLE_OPERATION.sql
    sed -i 's/$TABLE_OPERATION/$TABLE_TEMP_OPERATION/g' $PATH_DUMP/$NAME_OPERATION.$TABLE_OPERATION.sql

  }

#--------------------------------------------------------------------------------------------------------#

zabbix_sender_status_dump_information(){

    # In this place a sender for Zabbix is ​​implemented, configuring a trapper type item in the application.
    # In the -o parameter can be a mutable variable, sending up to 4 values ​​(0, 1, 2, 3) one for each status:
    # Success - Source(0) | Failure - Source(1) | Success - Destination(2) | Failure - Destination(3)
    ./bin/zabbix_sender -z $SERVER_FOR_ZABBIX_SENDER -s $HOST_FOR_ZABBIX_SENDER -k $KEY_ITEM_FOR_ZABBIX_SENDER -o $VALUE_FOR_ZABBIX_SENDER

  }

#--------------------------------------------------------------------------------------------------------#

run_main
