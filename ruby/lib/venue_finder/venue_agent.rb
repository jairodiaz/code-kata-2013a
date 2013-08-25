# An agent that searches for venues and keep favourties
class VenueAgent
  def initialize(foursquare_proxy)
    @foursquare_proxy = foursquare_proxy
  end

  def find(query)
    parse_results(@foursquare_proxy.search_venues(query))
  end

  private

  def parse_results(results)
    results.map { |venue| { name: venue["name"], favourite: false } }
  end
end
