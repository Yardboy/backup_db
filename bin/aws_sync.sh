# setup
PROFILE=$1
BUCKET=$2
FOLDER=~/s3backups/backup_files

# sync to aws s3
/usr/local/bin/aws s3 sync $FOLDER s3://$BUCKET --delete --profile $PROFILE
