require 'rspec'
require 'simplecov'
require 'pry'
SimpleCov.start

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib") <<
              File.join(File.dirname(__FILE__), "..", "spec")

require 'venue_finder'
