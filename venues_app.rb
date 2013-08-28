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
  @venues = VenueFinder.instance.find current_user, params[:query] if params[:query]
  erb :index
end

post '/favourite' do
  return status 500 unless params[:venue_id]
  VenueFinder.instance.add_favourite current_user, params
  status 200
end

delete '/favourite' do
  return status 500 unless params[:venue_id]
  VenueFinder.instance.remove_favourite current_user, params
  status 200
end

get '/list_favourites' do
  @favourites = VenueFinder.instance.list_favourites(current_user).values
  erb :favourites
end

def current_user
  session["session_id"]
end
