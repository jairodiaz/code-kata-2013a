require 'spec_helper'

feature 'Searching for a venue', :type => :feature do

  scenario 'Visiting the homepage' do
    visit '/'
    expect(page).to have_content 'Your venues'
    expect(page.find('input#query').text).to eq ''
    expect(page).to have_selector :link_or_button, 'search'
  end
end
