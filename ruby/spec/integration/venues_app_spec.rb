require 'spec_helper'

describe 'Venues Application' do

  it 'should load the home page' do
    visit '/'
    expect(page).to have_content "Hello"
  end
end
