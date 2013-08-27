require 'spec_helper'

describe VenueFinder::FavouritesStore do
  let(:store) { VenueFinder::FavouritesStore.new }

  let(:favourite) {
    {
      "venue_id" => "4c3234d866e40f478b21c68b",
      "name" => "Video City",
      "favourite" => true,
      "canonical_url" => "https://foursquare.com/v/video-city/4c3234d866e40f478b21c68b",
      "location" =>  {
         "address" => "Notting Hill GTe",
             "lat" => 51.50882711644852,
             "lng" => -0.19819456963498744,
        "distance" => 174,
            "city" => "Kensington",
           "state" => "Greater London",
         "country" => "United Kingdom",
              "cc" => "GB"
      }
    }
  }

  let(:favourite2) {
    {
      "venue_id" => "000034d866e40f478b21c68b",
      "name" => "Super Videos",
      "favourite" => true
    }
  }

  describe "#create" do
    it "should store a favourite for a user" do
      expect(store.create("1", favourite)).to be_true
    end

    context "when adding a second favourite" do
      it "should remember previous stored favourites" do
        store.create("1", favourite)
        store.create("1", favourite2)
        expect(store.where("1")).to eq({ "4c3234d866e40f478b21c68b" => favourite, "000034d866e40f478b21c68b" => favourite2 })
      end
    end
  end

  describe "#destroy" do
    it "should delete a favourite for a user" do
      store_1 = VenueFinder::FavouritesStore.new
      store_1.create("1", favourite)
      expect(store_1.destroy("1", favourite)).to be_true
    end
  end

  describe "#where" do
    context "when the user does not have stored favourites" do
      it "should be empty" do
        expect(store.where("user_id")).to be_empty
      end
    end

    context "when the user has favourites" do
      it "should return previous favourites" do
        store_1 = VenueFinder::FavouritesStore.new
        store_1.create("1", favourite)
        expect(store_1.where("1")).to eq({ "4c3234d866e40f478b21c68b" => favourite })
      end
    end
  end
end
