#! /usr/local/bin/ruby

Customer = Struct.new(:key, :bucket, :access_key, :secret_key)

class BackupDb
  require 'fileutils'
  require 'aws-sdk-s3'

  REGION = 'us-east-1'.freeze
  CUSTOMER = 'lbk'.freeze
  KEEP_FILES = 100
  BACKUP_FOLDER = 'backup_files'.freeze

  class NoAWSKeysError < StandardError; end

  attr_reader :customer

  def initialize
    @customer = Customer.new(CUSTOMER)
    puts "Initializing backup for #{customer.key.upcase}"
    configure_customer
    validate_aws_keys
    configure_aws
    puts "Uploading to bucket #{customer.bucket}"
  end

  def upload_latest
    ensure_backup_folder
    puts "Uploading latest file #{latest_backup_file}"
    begin
      stream_file_upload
      puts 'Success'
    rescue StandardError => e
      puts 'Error uploading file'
      puts e
    end
    remove_older_files
  end

  private

  def remove_older_files
    Array(list_bucket.sort_by(&:key).reverse[KEEP_FILES..]).each do |obj|
      puts "Removing #{obj.key}"
      s3_client.delete_object(bucket: customer.bucket, key: obj.key)
    end
  end

  def list_bucket
    objects = nil
    s3_client.list_objects(bucket: customer.bucket).each do |response|
      objects = response.contents
    end
    objects
  end

  def stream_file_upload
    File.open(backup_path, 'rb') do |file|
      s3_client.put_object(bucket: customer.bucket, key: latest_backup_file, body: file)
    end
  end

  def ensure_backup_folder
    puts 'Ensuring folder exists'
    FileUtils.mkdir_p BACKUP_FOLDER
  end

  def backup_path
    @backup_path ||= Dir["#{BACKUP_FOLDER}/*"].max_by { |f| File.mtime(f) }
  end

  def latest_backup_file
    return nil if backup_path.nil?

    File.basename(backup_path)
  end

  def configure_aws
    Aws.config.update(
      access_key_id: customer.access_key,
      secret_access_key: customer.secret_key,
      force_path_style: true,
      region: REGION
    )
  end

  def s3_client
    @s3_client ||= Aws::S3::Client.new
  end

  def configure_customer
    %w[bucket access_key secret_key].each do |fld|
      customer.send("#{fld}=", ENV["#{customer.key.upcase}_AWS_#{fld.upcase}"])
    end
  end

  def validate_aws_keys
    return if customer.access_key && customer.secret_key

    puts "Error with #{customer.key}"
    raise NoAWSKeysError
  end
end

backup_db = BackupDb.new
backup_db.upload_latest
