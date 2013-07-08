source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.13'

gem 'pg'
gem 'awesome_print'
gem 'haml-rails'
gem 'html2haml'
gem 'etsy', "~> 0.2.2"
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'zurb-foundation', '~> 4.0.0'
  
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do 
  gem 'debugger'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'mocha'
end

group :development do
  gem 'sextant'
end

#move these back into :test, :development before demo
gem 'faker'
gem "nifty-generators"
gem 'paperclip-aws'
gem 'rmagick'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'devise'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'koala'
gem 'flexslider'
