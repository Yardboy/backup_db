# create the ~/.aws folder
mkdir -p ~/.aws

# copy AWS config example file
cp ~/s3backups/examples/config.example ~/.aws/config

# copy AWS credentials example file
cp ~/s3backups/examples/credentials.example ~/.aws/credentials

# copy MySQL defaults example file
cp ~/s3backups/examples/.mysql.defaults.example ~/.mysql.defaults

# make scripts executable
chmod 700 ~/s3backups/bin/*

# make configuration files user-only
chmod 600 ~/.aws/*
chmod 700 ~/.aws
chmod 600 ~/.mysql.defaults
