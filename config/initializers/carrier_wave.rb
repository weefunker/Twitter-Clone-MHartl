if Rails?.env.production?
    CarrierWave.configure do |config| 
        config.credentials = {
            :provider   => 'AWS',
            :aws_provider_key_id => ENV['S3_ACCESS_KEY']
            :aws_secret_key => ENV['S3_SECRET_KEY'] 
        }
        config.fog_directory =ENV['S3_BUCKET']
    end 
end 