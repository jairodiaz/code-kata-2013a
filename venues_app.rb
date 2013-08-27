$: << File.join(File.dirname(__FILE__), ".", "lib")

require 'sinatra'
require 'venue_finder'
require 'awesome_print'
require 'pry'

enable :sessions

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
  if params[:query]
    @venues = VenueFinder.instance.find current_user, params[:query]
  end
  erb :index
end

post '/favourite' do
  if params[:venue_id]
    if params[:favourite] == "true"
      VenueFinder.instance.add_favourite current_user, params
      status 200
    else
      VenueFinder.instance.remove_favourite current_user, params
      status 200
    end
  end
end

get '/list_favourites' do
  @favourites = VenueFinder.instance.list_favourites(current_user).values
  erb :favourites
end

def current_user
  session["session_id"]
end
