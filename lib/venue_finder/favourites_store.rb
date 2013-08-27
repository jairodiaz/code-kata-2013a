module VenueFinder
  # Stores favourites.
  class FavouritesStore

    # Initialize the store.
    def initialize
      @store = {}
    end

    # Finds favourite for a given user.
    def where(user_id)
      return {} unless @store.has_key?(user_id)
      @store[user_id]
    end

    # Add a favourite for a given user.
    def create(user_id, favourite)
      @store[user_id] = {} unless @store[user_id]
      @store[user_id][favourite["venue_id"]] = favourite
    end

    # Remove a favourite for a given user.
    def destroy(user_id, favourite)
      if @store[user_id]
        @store[user_id].delete(favourite["venue_id"])
      end
    end
  end
end
