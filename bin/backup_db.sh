USER=$1
PW=$2
DB=$3
FOLDER=~/s3backups/backup_files
TS=`date +"%Y-%m-%d-%H-%M-%S"`
FILE=$FOLDER/db-backup-$TS.sql

mkdir -p $FOLDER

mysqldump -u $USER -p$PW --ignore-table=$DB.sessions $DB > $FILE

gzip $FILE

# delete files older than 10 days
find $FOLDER -type f -mtime +10 -delete
