require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start

require 'capybara'
require 'capybara/rspec' #support for feature/scenario
require 'capybara-webkit'

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")  <<
              File.join(File.dirname(__FILE__), "..", "spec") <<
              File.join(File.dirname(__FILE__), "..", ".")

require 'venue_finder'
require 'venues_app'
require_relative './support/venues_helper'

Capybara.app = Sinatra::Application.new
Capybara.save_and_open_page_path = File.join(File.dirname(__FILE__), "..", "tmp")
Capybara.javascript_driver = :selenium

# Important note about using: webkit (:webkit)
# 1. Webkit does not support HTTP Verb delete, so deleting a favourite fails.
# 2. VCR is not compatible with capybara-wekbit, so test are slow and test
#    for listing favourites fails due to different recorded reply.

RSpec.configure do |config|
  config.include Capybara::DSL
end

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  #c.allow_http_connections_when_no_cassette = true #Use when running with webkit
  c.ignore_localhost = true
end
