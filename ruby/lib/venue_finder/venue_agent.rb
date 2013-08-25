# An agent that searches for venues and keep favourties.
class VenueAgent

  # Initialize dependencies.
  # @param foursquare_proxy The Foursquare Proxy to retrieve the venues from.
  # @param favourites_store The store to save/retrieve the favourites list.
  def initialize(foursquare_proxy, favourites_store)
    @foursquare_proxy = foursquare_proxy
    @favourites_store = favourites_store
  end

  # Find venues based on a query string and displays favourite results if present.
  def find(user_id, query)
    favourites = @favourites_store.where(user_id: user_id)
    venues = @foursquare_proxy.search_venues(query)
    parse_results(venues, favourites)
  end

  private

  def parse_results(venues, favourites)
    venues.map { |venue| { name: venue["name"], favourite: false } }
  end
end
