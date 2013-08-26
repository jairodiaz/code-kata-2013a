require 'spec_helper'

feature 'Managing favourite venues' do

  scenario 'Saving a favourite', js: true do
    search_for 'video'
    check 'favourite_1'

    visit '/' #clean the current output
    search_for 'video'

    expect(find(:css, '#favourite_1')).to be_checked
  end

  scenario 'Removing a favourite', js: true do
    search_for 'video'
    check 'favourite_1'

    visit '/' #clean the current output
    search_for 'video'
    uncheck 'favourite_1'

    visit '/' #clean the current output
    search_for 'video'
    expect(find(:css, '#favourite_1')).not_to be_checked
  end
end
