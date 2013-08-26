require 'spec_helper'

feature 'Managing favourite venues' do

  # Note: VCR is not compatible with capybara-wekbit
  # therefore it is not used in JS tests.

  scenario 'Saving a favourite', js: true do
    search_for 'video'
    check 'favourite_1'

    search_for 'video' #clean the current output
    expect(find(:css, '#favourite_1')).to be_checked
  end

  scenario 'Removing a favourite', js: true do
    search_for 'video'
    check 'favourite_1'

    search_for 'video' #check that favourite is saved
    uncheck 'favourite_1'

    search_for 'video'
    expect(find(:css, '#favourite_1')).not_to be_checked
  end

  scenario 'Displaying favourites' do
    VCR.use_cassette('video') do
      search_for 'video'
    end
    check 'favourite_1'

    click_link 'My favourites'
    expect(page).to have_content 'Music & Video Exchange'
  end
end
