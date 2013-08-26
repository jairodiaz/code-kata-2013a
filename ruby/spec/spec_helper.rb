require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start

require 'capybara'
require 'capybara/rspec' #support for feature/scenario

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")  <<
              File.join(File.dirname(__FILE__), "..", "spec") <<
              File.join(File.dirname(__FILE__), "..", ".")

require 'venue_finder'
require 'venues_app'
require_relative './support/venues_helper'

Capybara.app = Sinatra::Application
Capybara.save_and_open_page_path = File.join(File.dirname(__FILE__), "..", "tmp")

RSpec.configure do |config|
  config.include Capybara::DSL
end
