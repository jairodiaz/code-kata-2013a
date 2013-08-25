# Stores favourites and defines an interface similar to active_record for coupling to rails.
class FavouritesStore

  # Initialize the store.
  def initialize
    @store = {}
  end

  # Finds favourite for a given user.
  # @param options Hash of the form { user_id: 'valid-user-id'}
  def where(options)
    return [] unless @store.has_key?(options[:user_id])
    @store[options[:user_id]]
  end

  # Add a favourite for a given user.
  # @param options Has of the form { user_id: 'valid-user-id', venue_id: 'valid-name-to-store'}
  def create(options)
    if @store[options[:user_id]]
      @store[options[:user_id]] << options[:venue_id]
    else
      @store[options[:user_id]] = [options[:venue_id]]
    end
  end

  # Remove a favourite for a given user.
  # @param options Has of the form { user_id: 'valid-user-id', name: 'valid-name-to-store'}
  def destroy_all(options)
    if @store[options[:user_id]]
      @store[options[:user_id]].reject! { |favourite| favourite == options[:venue_id] }
      true
    else
      false
    end
  end
end
