require 'spec_helper'

describe FavouritesStore do
  let(:store) { FavouritesStore.new }

  describe "#create" do
    it "should store a favourite for a user" do
      expect(store.create(user_id: "1", name: "apple")).to be_true
    end
  end

  describe "#destroy_all" do
    it "should delete a favourite for a user" do
      store_1 = FavouritesStore.new
      store_1.create(user_id: "1", name: "apple")
      expect(store_1.destroy_all(user_id: "1", name: "apple")).to be_true
    end
  end

  describe "#where" do
    context "when the user does not have stored favourites" do
      it "should be empty" do
        expect(store.where(user_id: "user_id")).to be_empty
      end
    end

    context "when the user has favourites" do
      it "should return previous favourites" do
        store_1 = FavouritesStore.new
        store_1.create(user_id: "1", name: "apple")
        expect(store_1.where(user_id: "1")).to eq ["apple"]
      end
    end
  end
end
