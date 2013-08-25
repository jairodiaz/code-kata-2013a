require 'spec_helper'

describe FavouritesStore do
  let(:store) { FavouritesStore.new }

  describe "#create" do
    it "should store a favourite for a user" do
      expect(store.create(user_id: "1", name: "apple")).to be_true
    end
  end

  describe "#where" do
    context "when the user does not have stored favourites" do
      it "should be empty" do
        expect(store.where(user_id: "user_id")).to be_empty
      end
    end
  end
end
