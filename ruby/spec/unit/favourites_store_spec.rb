require 'spec_helper'

describe FavouritesStore do

  describe "#where" do
    context "when created" do
      it "should be empty" do
        store = FavouritesStore.new
        expect(store.where(user_id: "user_id")).to be_empty
      end
    end
  end
end
