require 'spec_helper'

describe FoursquareProxy do

  let(:proxy) { FoursquareProxy.new }

  describe "#search_venues" do
    it "should return an Array" do
      expect(proxy.search_venues("music").class).to eq Array
    end
  end
end
