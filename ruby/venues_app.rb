require 'sinatra'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  'Hello World'
end
