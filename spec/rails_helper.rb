# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
end
