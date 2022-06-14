# setup
DB=$1
IGNORES=$DB.sessions
FOLDER=~/s3backups/backup_files
TS=`date +"%Y-%m-%d-%H-%M-%S"`
FILE=$FOLDER/db-backup-$TS.sql
MYSQL=~/.mysql.defaults

# make sure backups folder is there
mkdir -p $FOLDER

# dump the database
mysqldump --defaults-extra-file=$MYSQL --ignore-table=$IGNORES $DB > $FILE

# compress the dump file
gzip $FILE

# delete files older than 10 days
find $FOLDER -type f -mtime +10 -delete
