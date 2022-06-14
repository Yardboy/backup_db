# create the ~/.aws folder
mkdir -p ~/.aws

# copy AWS config example file
cp ~/s3backups/examples/config.example ~/.aws/config

# copy AWS credentials example file
cp ~/s3backups/examples/credentials.example ~/.aws/credentials

# copy MySQL defaults example file
cp ~/s3backups/examples/.mysql.defaults.example ~/.mysql.defaults
