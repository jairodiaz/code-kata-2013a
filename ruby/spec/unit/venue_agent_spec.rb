require "spec_helper"

describe VenueAgent do
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

  before(:each) do
    @source = double('foursquare_proxy')
    @store = double('favourites_store')
    @source.stub(:search_venues).with('video').and_return(source_response)
  end

  describe "#find" do
    context "when there is no previous favourites" do
      it "should return a list of venues" do
        @store.stub(:where).with({user_id: 'user_id'}).and_return([])
        agent = VenueAgent.new(@source, @store)
        expect(agent.find('user_id', 'video')).to eq [ { name: "Video City", favourite: false },
                                            { name: "Music & Video Exchange", favourite: false } ]
      end
    end

    context "when there is previous favourites" do
      it "should return a list of venues with favourites" do
        @store.stub(:where).with({user_id: 'user_id'}).and_return(["Video City"])
        agent = VenueAgent.new(@source, @store)
        expect(agent.find('user_id', 'video')).to eq [ { name: "Video City", favourite: true },
                                            { name: "Music & Video Exchange", favourite: false } ]
      end
    end
  end

  describe "#add_favourite" do
    it "should store a favourite in the favourites_store" do
      @store.should_receive(:create).with({user_id: 'user_id', name: 'apple'}).and_return(true)
      VenueAgent.new(@source, @store).add_favourite('user_id', 'apple')
    end
  end

  describe "#remove_favourite" do
    it "should remove a favourite in the favourites_store" do
      @store.should_receive(:destroy_all).with({user_id: 'user_id', name: 'apple'}).and_return(true)
      VenueAgent.new(@source, @store).remove_favourite('user_id', 'apple')
    end
  end
end