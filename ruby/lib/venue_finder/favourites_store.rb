# Stores favourites and defines an interface similar to active_record for coupling to rails.
class FavouritesStore
  def initialize
    @store = {}
  end

  def where(options)
    return [] unless @store.has_key?(options[:user_id])
    @store[options[:user_id]]
  end

  def create(options)
    if @store[options[:user_id]]
      @store[options[:user_id]] << options[:name]
    else
      @store[options[:user_id]] = [options[:name]]
    end
  end
end
