# README - S3backups Utility Scripts

This is a simple set of scripts to dump a MySQL database to a folder
and sync that folder to an AWS S3 bucket.

# Setup
Run install script to set up folders and configuration files

`~/s3backups/bin/install.sh`

# Configure
Update `~/.aws/config` with appropriate region and bucket

Update `~/.aws/credentials` with appropriate aws credentials

Update `~/.mysql.defaults` with appropriate MySQL credentials

Make all of these files visible to user only

`chmod 600 ~/.aws/*`

`chomd 700 ~/.aws`

`chmod 600 ~/.mysql.defaults`

# Use

## CRON backup script

Set up cron job to run the `backup_db.sh` script

`0 * * * * /bin/bash -l -c "/home/pragmatim/s3backups/bin/backup_db.sh DB" >> /home/pragmatim/s3backups/log_files/backup.log 2>&1`

*where **DB** is the name of the database to backup*

## CRON sync script

Set up cron job to run the `aws_sync.sh` script

`15 */4 * * * /bin/bash -l -c "/home/pragmatim/s3backups/bin/aws_sync.sh PROFILE BUCKET" >> /home/pragmatim/s3backups/log_files/sync.log 2>&1`

*where **PROFILE** is the `[profile]` value in `~/.aws/config`*

*and **BUCKET** is the S3 bucket you are syncing to*