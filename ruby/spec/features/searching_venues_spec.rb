require 'spec_helper'

feature 'Searching for a venue' do

  scenario 'Visiting the homepage' do
    visit '/'
    expect(page).to have_content 'Your venues'
    expect(page.find('input#query').text).to eq ''
    expect(page).to have_selector :link_or_button, 'search'
  end

  scenario 'Searching for a keyword' do
    visit '/'
    fill_in 'query', with: 'video'
    VCR.use_cassette('video') do
      click_button 'search'
    end

    expect(page).to have_content 'Matching Venues'
    expect(page).to have_content 'Video City'
    expect(page).to have_content 'Music & Video Exchange'
  end
end
