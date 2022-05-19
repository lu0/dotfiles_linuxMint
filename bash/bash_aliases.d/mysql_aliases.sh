#!/usr/bin/env bash

# alias mysql="mysql --defaults-extra-file=~/.mysql-p"

function mylu() {
    usage() {
        echo
        echo "My utilities for mysql :D"
        echo
        echo "Usage: mylu [OPTION]"
        echo
        echo "Options:"
        echo "   -b     Backup a database"
        echo "   -r     Restore a backup"
        echo "   -l     List of backups"
        echo "   -e     List empty databases"
        echo "   -a     List all databases"
        echo
    }

    emptydb() {
        mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -e "SELECT S.SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA S LEFT OUTER
                      JOIN INFORMATION_SCHEMA.TABLES T ON S.SCHEMA_NAME = T.TABLE_SCHEMA
                      WHERE T.TABLE_SCHEMA IS NULL"
    }

    BACKUP_PATH=~/code/learning/sql/ssydb_history/

    PASSED_OPT="true"
    local OPTIND=1
    while getopts :brlea opt; do
        case $opt in
        b)
            echo
            echo -n 'Select the database you want to backup'
            echo
            mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -e "SHOW DATABASES" | grep -e "[^Database]" | grep -n ".*"
            mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -e "SHOW DATABASES" | grep -e "[^Database]" | grep -n ".*" >${BACKUP_PATH}all-dbs.log
            read BACKUP_NUM
            echo
            DB_DATE=$(date +'%y%m%d-%H%M%S')
            DB_NAME=$(grep -e "^${BACKUP_NUM}:" ${BACKUP_PATH}all-dbs.log | cut -d ':' -f 2)
            echo ${DB_NAME}
            mysqldump --defaults-extra-file=~/.mysqldump.cnf ${DB_NAME} --column-statistics=0 >${BACKUP_PATH}${DB_DATE}-${DB_NAME}.sql
            echo ${BACKUP_PATH}${DB_DATE}-${DB_NAME}.sql
            unset BACKUP_NUM DB_NAME DB_DATE
            return
            ;;
        r)
            echo
            echo -n 'Name the database you want to restore in: '
            read DB_NEW
            echo

            #   DB_EXISTS=$(mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -e "SHOW DATABASES" | grep -sw ${DB_NEW})
            #   [ ! -z ${DB_EXISTS} ] && echo "${DB_NEW} already exists" && return

            QUERY="USE ${DB_NEW}; \
      SET FOREIGN_KEY_CHECKS = 0; \
      SET GROUP_CONCAT_MAX_LEN=32768; \
      SET @tables = NULL; \
      SELECT GROUP_CONCAT(table_name) INTO @tables \
      FROM information_schema.tables \
      WHERE table_schema = (SELECT DATABASE()); \
      SELECT IFNULL(@tables,'dummy') INTO @tables; \
      \
      SET @tables = CONCAT('DROP TABLE IF EXISTS ', @tables); \
      PREPARE stmt FROM @tables; \
      EXECUTE stmt; \
      DEALLOCATE PREPARE stmt; \
      SET FOREIGN_KEY_CHECKS = 1;"
            echo "${QUERY}"
            mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -e "${QUERY}"

            ls ${BACKUP_PATH} | grep -e ".*.sql$" >${BACKUP_PATH}backups-ls.log
            # ls ${BACKUP_PATH} | grep -e "^[0-9]\{6\}-[0-9]\{6\}-\?.*.sql$" > ${BACKUP_PATH}backups-ls.log
            echo -n 'Select the file you want to restore: '
            echo
            grep -ne ".*" ${BACKUP_PATH}backups-ls.log
            read BACKUP_NUM
            echo
            RESTORE_FILE=$(head -${BACKUP_NUM} ${BACKUP_PATH}backups-ls.log | tail -1)
            #    mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -e "CREATE DATABASE ${DB_NEW}"
            mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -D ${DB_NEW} <${BACKUP_PATH}${RESTORE_FILE}
            mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -D ${DB_NEW} -e "SHOW TABLES"
            unset BACKUP_NUM DB_NEW RESTORE_FILE
            return
            ;;
        l)
            ls ${BACKUP_PATH} | grep -e "^[0-9]\{6\}-[0-9]\{6\}-\?.*.sql$" >${BACKUP_PATH}backups-ls.log
            grep -ne ".*" ${BACKUP_PATH}backups-ls.log
            return
            ;;
        e)
            emptydb
            return
            ;;
        a)
            mysql -h 0.0.0.0 --port=8081 -u root -ptestserver -e "SHOW DATABASES"
            return
            ;;
        *)
            usage
            return
            ;;
        esac
    done

    PASSED_OPT=
    [ -z "$PASSED_OPT" ] && usage && return
}
