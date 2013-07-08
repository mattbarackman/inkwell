require "open-uri"

class Photo < ActiveRecord::Base
  attr_accessor :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  
  attr_accessible :data
  belongs_to :card

  def picture_from_url(url)
    self.data = open(url)
  end

  def self.s3_config
    if Rails.env.production?
      @@s3_config = {'access_key_id' => ENV['access_key_id'],
                     'secret_access_key' => ENV['secret_access_key'],
                     'endpoint' => ENV['endpoint:'],
                     'bucket' => ENV['bucket'],
                     'host_alias' => ENV['host_alias'],
                    }
    else
      @@s3_config = YAML.load_file("#{Rails.root}/config/s3.yml")
    end
  end

  has_attached_file :data,
                    :styles => {
                      :thumb => [">100x"],
                      :medium => [">300x"],
                      :full => [">600x"]
                      },                    
                      :storage => :aws,
                      :s3_credentials => {
                        :access_key_id => self.s3_config['access_key_id'],
                        :secret_access_key => self.s3_config['secret_access_key'],
                        :endpoint => self.s3_config['endpoint']
                      },
                      :bucket => self.s3_config['bucket'],                    
                      # :s3_host_alias => self.s3_config['host_alias'],
                      :s3_permissions => :public_read,
                      :s3_protocol => 'http',
                      :s3_options => {
                        :server_side_encryption => 'AES256',
                        :storage_class => :reduced_redundancy,
                        :content_disposition => 'attachment'
                        },

                        :path => "card_images/:id/:style/:data_file_name"  

      end
