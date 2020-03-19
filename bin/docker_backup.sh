USER=db_user_name
PW=db_password
DB=db_name
FOLDER=~/backup_db/backups
TS=`date +"%Y-%m-%d-%H-%M-%S"`
FILE=$FOLDER/db-backup-$TS.sql

mkdir -p $FOLDER

mysqldump -u $USER -p$PW --ignore-table=$DB.sessions $DB > $FILE

gzip $FILE

# delete files older than 10 days
find $FOLDER -type f -mtime +10 -delete
