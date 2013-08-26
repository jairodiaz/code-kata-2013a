require 'spec_helper'

describe VenueFinder::FoursquareProxy do

  let(:proxy) { VenueFinder::FoursquareProxy.new }
  let(:a_venue) {
    VCR.use_cassette('video') do
      proxy.search_venues("video").first
    end
  }

  describe "#search_venues" do
    it "should return an Array of venues" do
      VCR.use_cassette('video') do
        expect(proxy.search_venues("video").class).to eq Array
      end
    end

    describe "a venue" do
      it "should have an id" do
        expect(a_venue["id"]).to eq "4c3234d866e40f478b21c68b"
      end

      it "should have a name" do
        expect(a_venue["name"]).to eq "Video City"
      end

      it "should have a location" do
        location_hash = {
           "address" => "Notting Hill GTe",
               "lat" => 51.50882711644852,
               "lng" => -0.19819456963498744,
          "distance" => 174,
              "city" => "Kensington",
             "state" => "Greater London",
           "country" => "United Kingdom",
                "cc" => "GB"
        }
        expect(a_venue["location"]).to eq location_hash
      end

      it "should have a canonical url" do
        expect(a_venue["canonicalUrl"]).to eq "https://foursquare.com/v/video-city/4c3234d866e40f478b21c68b"
      end
    end
  end
end
