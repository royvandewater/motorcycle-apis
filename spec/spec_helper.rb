require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

require 'spork'
Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  # no more proxy
  ENV['http_proxy'] = ''
  ENV['https_proxy'] = ''
  ENV['ftp_proxy'] = ''

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  require 'database_cleaner'
  require 'capybara/rspec'
  require 'capybara/poltergeist'

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new app, :inspector => true # , :debug => true
  end
  Capybara.javascript_driver = :poltergeist

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    # config.include Requests::JsonHelpers, :type => :request
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation, {:pre_count => true, :reset_ids => false}
      DatabaseCleaner.clean_with(:truncation)
    end

    [:model, :controller, :helper, :mailer, :routing, :view].each do |type|
      config.before :type => type do
        DatabaseCleaner.strategy = :transaction
      end
    end

    config.before :type => :request do
      DatabaseCleaner.strategy = :truncation, {:pre_count => true, :reset_ids => false}
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
      DatabaseCleaner.strategy = :truncation, {:pre_count => true, :reset_ids => false}

      if example.exception.present?
        take_screenshot :prefix => example.description
      end
    end
  end

  # class ActiveRecord::Base
  #   mattr_accessor :shared_connection
  #   @@shared_connection = nil

  #   def self.connection
  #     @@shared_connection || retrieve_connection
  #   end
  # end

  # Forces all threads to share the same connection. This works on
  # Capybara because it starts the web server in a thread.
  # ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

  include ActionController::RecordIdentifier
end

