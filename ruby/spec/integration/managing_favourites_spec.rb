require 'spec_helper'

feature 'Searching for a venue' do

  scenario 'Saving a favourite' do
    search_for 'video'
    check 'favourite_1'
    save_and_open_page
  end

  scenario 'Removing a favourite'
end
