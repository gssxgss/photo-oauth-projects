CarrierWave.configure do |config|
  config.storage = :file
  config.root = Rails.root.join('public')
  config.asset_host = 'http://localhost:3000'
end
