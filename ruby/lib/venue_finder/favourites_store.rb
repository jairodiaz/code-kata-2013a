# Stores favourites and defines an interface similar to active_record for coupling to rails.
class FavouritesStore
  def initialize
    @store = {}
  end
  def where(options)
    []
  end
end
