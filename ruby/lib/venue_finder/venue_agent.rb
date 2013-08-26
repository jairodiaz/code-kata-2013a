module VenueFinder
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

    # Saves a favourite for a given user.
    def add_favourite(user_id, favourite_name)
      @favourites_store.create(user_id: user_id, favourite: favourite_name)
    end

    # Removes a favourite for a given user.
    def remove_favourite(user_id, favourite_name)
     @favourites_store.destroy(user_id: user_id, favourite: favourite_name)
    end

    # Retrieves the list of favourites.
    def list_favourites(user_id)
     @favourites_store.where({user_id: user_id})
    end

    private

    def parse_results(venues, favourites)
      venues.map do |venue|
        {
          venue_id: venue["id"],
          name: venue["name"],
          favourite: favourites.map{ |favorite| favorite[:venue_id] }.include?(venue["id"]),
          canonical_url: venue["canonicalUrl"],
          location: venue["location"]
        }
      end
    end
  end
end
