CarrierWave.configure do |config|
  config.s3_access_key_id = 'AKIAIRZHHM7NFZ7WBM4A'
  config.s3_secret_access_key = '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'
  config.s3_bucket = 'gogolfprod'
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  #config.s3_access_policy = :public_read
  #config.s3_headers = {'Cache-Control' => 'max-age=315576000'}
  #config.s3_region = 'eu-west-1'
  #config.s3_cnamed = true
end