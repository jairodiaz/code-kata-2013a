require 'foursquare2'

module VenueFinder
  class FoursquareProxy
    CLIENT_ID = 'AV03ZKZYEYRCHDPEIJN4QDMCZV30M5UM14XWSONSNS3YQFNV'
    CLIENT_SECRET = 'HICXJ5YBXQRJGH0GW0DIYXGSNGAKYXWCK5WL00EWMPHRE1CJ'
    API_VERSION = '20130101'

    LAT = 51.508857899999995
    LONG = -0.195678

    def initialize
      @client = Foursquare2::Client.new(:client_id => CLIENT_ID, :client_secret => CLIENT_SECRET, :version => API_VERSION)
    end

    def search_venues query
      @client.search_venues(:ll => "#{LAT},#{LONG}", :query => query).groups.first.items
    end
  end
end
