source 'https://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'bootstrap-sass', '~> 2.0.4.0'
  gem 'bootswatch-rails', '~> 0.0.12'
  gem 'font-awesome-sass-rails', '~> 2.0.0.0'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '~> 1.2.6'
end

gem 'jquery-rails', '~> 2.0.2'
gem 'mongoid', '~> 3.0.1'
gem 'bson_ext', '~> 1.6.4'
gem 'haml', '~> 3.1.6'
gem 'haml-rails', '~> 0.3.4'
gem 'omniauth', '~> 1.1.0'
gem 'omniauth-facebook', '~> 1.3.0'
gem 'simple_form', '~> 2.0.2'
gem 'thin', '~> 1.4.1'

group :test, :development do
  gem 'rspec-rails', '~> 2.11.0'
  gem 'heroku'
end

group :test do
  # Don't put this in the development group, because it disables all net connections by default !!!
  gem 'database_cleaner', '~> 0.8.0'
  gem 'spork', '~> 0.9.2'
  gem 'factory_girl_rails', '~> 3.5.0', require: false
end

group :production do
  gem 'unicorn', '~> 4.3.0'
end
