def search_for(query)
  visit '/'
  fill_in 'query', with: query
  click_button 'search'
end
