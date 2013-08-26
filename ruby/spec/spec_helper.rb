require 'rspec'
require 'simplecov'
require 'pry'
require 'sinatra'
require 'capybara'

SimpleCov.start

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara::DSL
end

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")  <<
              File.join(File.dirname(__FILE__), "..", "spec") <<
              File.join(File.dirname(__FILE__), "..", ".")

require 'venue_finder'
