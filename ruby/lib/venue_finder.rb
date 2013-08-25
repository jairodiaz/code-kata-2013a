require 'venue_finder/foursquare_proxy'
require 'venue_finder/venue_agent'
require 'venue_finder/favourites_store'

module VenueFinder
  def self.instance
    @venue_agent ||= VenueAgent.new(FoursquareProxy.new, FavouritesStore.new)
  end
end
