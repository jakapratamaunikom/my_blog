require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Spork.prefork do
  Rails.env = 'test'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.run_all_when_everything_filtered = true
    config.infer_spec_type_from_file_location!
    config.render_views = true

    config.before(:each, :type => :controller) do
      session[:is_admin] = true
    end

  end
end

Spork.each_run do
  # This code will be runs each time when you run specs.
  Dir[Rails.root + "app/**/*.rb"].each do |file|
    next if file.include?("/concerns/")
    load file
  end
  FactoryGirl.reload

end
