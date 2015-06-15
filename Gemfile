source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'compass-rails', '~> 2.0.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'execjs'

# Slim
gem 'slim'
gem 'slim-rails'

# Use spine-js as the JavaScript library
gem "json2-rails"
gem 'eco'
gem 'underscore-rails'

# JS notigications
gem "messengerjs-rails", "~> 1.4.1" 
# JS select
gem "selectize-rails"
#For js-upload images
gem "jquery-fileupload-rails"

# Localization
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x
# For javascript locaes
gem "i18n-js"
# For flag icongs
gem 'famfamfam_flags_rails'


# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Bootstrap
# gem 'bootstrap-sass', '~> 3.2.0' # use bootstrap from design. it's some modified

# For form validate
gem 'jquery-validation-rails'

#For form objects
gem 'virtus'

gem 'tasty_breadcrumbs', git: 'git://github.com/valexl/tasty_breadcrumbs.git'
# gem 'tasty_breadcrumbs', path: '/Users/valexl/workspace/tasty_breadcrumbs/'

#For working with images
gem "rmagick"
gem 'carrierwave'

#For truncate html
gem 'truncate_html'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
  gem 'unicorn'
  
  #web server 
  gem 'puma'

end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'rvm1-capistrano3', require: false
  gem 'capistrano-rails-console'
end





group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'


  gem 'rspec-rails'
  gem 'factory_girl_rails'
  # gem 'database_cleaner' #чистит тестувую базу
  # gem 'capybara'
  #Generate humanize random data
  gem 'forgery' 

  
  gem 'spork', git: 'git://github.com/manafire/spork.git', ref: '38c79dcedb246daacbadb9f18d09f50cc837de51'
  gem 'spork-rails', '~> 4.0.0'

  gem 'guard-rails'
  gem 'guard-rspec', '~> 4.5.0', require: false
  gem 'guard-livereload'
  gem 'guard-bundler'
  gem 'guard-spork'

end

