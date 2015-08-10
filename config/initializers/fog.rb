CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJOJC5CTYELAWPZBQ',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-1',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'bucket-dev-teemaero'                          # required

end