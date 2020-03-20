# README

This is a simple docker-compose container with a ruby script to
upload the latest backup file (created by included docker_backup.sh
shell script or otherwise) from a local folder into an S3 bucket.

How to use:

* Configure and install backup_db.sh into crontab

* Update `CUSTOMER` constant in `s3backups.rb` with customer key

* Configure a `.env` file for the customer key according to `.env.example`

* Run `bin/dev build` once to build the container

* Run `bin/dev up` any time to run the backup upload

* Run `bin/dev bash` to enter the container at a bash prompt
