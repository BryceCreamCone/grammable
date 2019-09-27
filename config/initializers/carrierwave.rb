CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_public = false
  config.fog_credentials = {
    provider:                 'AWS',
    aws_access_key_id:        ENV.fetch("AWS_ACCESS_KEY"),
    aws_secret_access_key:    ENV.fetch("AWS_SECRET_KEY")
  }
  config.fog_directory = ENV.fetch("AWS_BUCKET")
end