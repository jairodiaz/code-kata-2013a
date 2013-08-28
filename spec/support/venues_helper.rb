def search_for(query)
  visit '/'
  fill_in 'query', with: query
  VCR.use_cassette(query) do
    click_button 'search'
  end
end
