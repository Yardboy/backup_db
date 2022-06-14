# README - S3backups Utility Scripts

This is a simple set of scripts to dump a MySQL database to a folder
and sync that folder to an AWS S3 bucket.

# Install Necessary Utilities

## Docker

`sudo apt install docker-ce`

## Git

`sudo apt install git git-core -Y`

## AWS CLI

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`

`unzip awscliv2.zip`

`sudo ./aws/install`

`rm -fr ~/aws`

# Clone

Clone the S3Backups repo into the user home folder

`git clone https://github.com/Yardboy/s3backups.git`

# Setup
Run the install script to set up folders and configuration files

`~/s3backups/bin/install.sh`

# Configure
Update `~/.aws/config` with appropriate region

Update `~/.aws/credentials` with appropriate aws credentials

Update `~/.mysql.defaults` with appropriate MySQL credentials

Make all of these files visible to user only

`chmod 600 ~/.aws/*`

`chomd 700 ~/.aws`

`chmod 600 ~/.mysql.defaults`

# Test

Confirm that backup script works

`/home/pragmatim/s3backups/bin/backup_db.sh DB`

*where **DB** is the name of the database to backup*

Confirm that sync script works

`/home/pragmatim/s3backups/bin/aws_sync.sh PROFILE BUCKET`

*where **PROFILE** is the `[profile]` value in `~/.aws/config`*
*and **BUCKET** is the S3 bucket you are syncing to*

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