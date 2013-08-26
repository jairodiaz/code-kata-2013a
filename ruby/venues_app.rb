$: << File.join(File.dirname(__FILE__), ".", "lib")

require 'sinatra'
require 'venue_finder'
require 'awesome_print'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def checker(boolean)
    'checked' if boolean
  end

  def address(address)
    begin
      location = "#{address['address']}&nbsp;#{address['postalCode']}"
    rescue
     "&nbsp;"
    end
  end
end

get '/' do
  erb :index
end

post '/' do
  if params[:query] and not params[:query].empty?
    @venues = VenueFinder.instance.find current_user, params[:query]
  end
  erb :index
end

def current_user
  '1'
end
