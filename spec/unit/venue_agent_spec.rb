require "spec_helper"

describe VenueFinder::VenueAgent do
   let(:source_response) {
    [
        {"id" => "4c3234d866e40f478b21c68b",
        "name" => "Video City",
        "location" => {
             "address" => "Notting Hill GTe",
                 "lat" => 51.50882711644852,
                 "lng" => -0.19819456963498744,
            "distance" => 174,
                "city" => "Kensington",
               "state" => "Greater London",
             "country" => "United Kingdom",
                  "cc" => "GB"
        },
        "canonicalUrl" => "https://foursquare.com/v/video-city/4c3234d866e40f478b21c68b"},

       {"id" => "4c76780066be6dcbc829c30f",
        "name" => "Music & Video Exchange",
        "location" => {
               "address" => "38-42 Notting Hill Gate",
                   "lat" => 51.509317,
                   "lng" => -0.194834,
              "distance" => 77,
            "postalCode" => "W11",
                  "city" => "London",
                 "state" => "Greater London",
               "country" => "United Kingdom",
                    "cc" => "GB"
        },
        "canonicalUrl" => "https://foursquare.com/v/music--video-exchange/4c76780066be6dcbc829c30f"}
    ]
  }

  let(:location_for_video_city) {
    {
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

  let(:location_for_music_and_video_exchange) {
   {
         "address" => "38-42 Notting Hill Gate",
             "lat" => 51.509317,
             "lng" => -0.194834,
        "distance" => 77,
      "postalCode" => "W11",
            "city" => "London",
           "state" => "Greater London",
         "country" => "United Kingdom",
              "cc" => "GB"
    }
  }

  let(:venue_video_city) {
    {
      "venue_id" => "4c3234d866e40f478b21c68b",
      "name" => "Video City",
      "favourite" => false,
      "canonical_url" => "https://foursquare.com/v/video-city/4c3234d866e40f478b21c68b",
      "location" => location_for_video_city
    }
  }

  let(:venue_music_and_video_exchange) {
    {
      "venue_id" => "4c76780066be6dcbc829c30f",
      "name" => "Music & Video Exchange",
      "favourite" => false,
      "canonical_url" => "https://foursquare.com/v/music--video-exchange/4c76780066be6dcbc829c30f",
      "location" => location_for_music_and_video_exchange
    }
  }

  let(:favourite) {
    {
      "venue_id" => "4c3234d866e40f478b21c68b",
      "name" => "Video City",
      "favourite" => true,
      "canonical_url" => "https://foursquare.com/v/video-city/4c3234d866e40f478b21c68b",
      "location" => location_for_video_city
    }
  }

  before(:each) do
    @source = double('foursquare_proxy')
    @store = double('favourites_store')
    @source.stub(:search_venues).with('video').and_return(source_response)
  end

  describe "#find" do
    context "when there is no previous favourites" do
      it "should return a list of venues" do
        results = [venue_video_city, venue_music_and_video_exchange]
        @store.stub(:where).with('user_id').and_return({})
        agent = VenueFinder::VenueAgent.new(@source, @store)
        expect(agent.find('user_id', 'video')).to eq results
      end
    end

    context "when there is previous favourites" do
      it "should return a list of venues with favourites" do
        favorited_video_city = venue_video_city
        favorited_video_city["favourite"] = true
        results = [favorited_video_city, venue_music_and_video_exchange]
        @store.stub(:where).with('user_id').and_return({"4c3234d866e40f478b21c68b" => favourite})
        agent = VenueFinder::VenueAgent.new(@source, @store)
        expect(agent.find('user_id', 'video')).to eq results
      end
    end
  end

  describe "#add_favourite" do
    it "should store a favourite in the favourites_store" do
      @store.should_receive(:create).with('user_id', favourite).and_return(true)
      VenueFinder::VenueAgent.new(@source, @store).add_favourite('user_id', favourite)
    end
  end

  describe "#remove_favourite" do
    it "should remove a favourite in the favourites_store" do
      @store.should_receive(:destroy).with('user_id', favourite).and_return(true)
      VenueFinder::VenueAgent.new(@source, @store).remove_favourite('user_id', favourite)
    end
  end

  describe "#list_favourites" do
    it "should display the list of favourites" do
      @store.should_receive(:where).with('user_id').and_return({"4c3234d866e40f478b21c68b" => favourite})
      VenueFinder::VenueAgent.new(@source, @store).list_favourites('user_id')
    end
  end
end
