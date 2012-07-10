require 'spec_helper'

describe 'User Link wall' do
  it 'User can add a new link', :js => true do
    visit root_path
    fill_in "new_link_url", with: "http://some.com"
    click_button "Share"
    within('#links') do
      page.should have_content("some.com")
    end
  end
  it 'User can see a list of links'
  it 'When a link is clicked the count it updated'
  it 'The links can view viewed on a recent order'
  it 'The links can view viewed on a popular order'

end
