ENV['RACK_ENV'] = 'test' # Need to put this before requiring app.rb!!

require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require File.join(File.dirname(__FILE__), '../app/', 'app.rb')

require 'database_helper'
require 'features/web_helpers'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

Capybara.app = Chitter

RSpec.configure do |config|

  config.before(:each) do
    wipe_database
    allow(SendMail).to receive(:send)
  end

  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
