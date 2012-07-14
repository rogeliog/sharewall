require 'spec_helper'

describe 'User Link wall' do
  it 'User can add a new link', js: true do
    visit root_path
    fill_in "new_link_url", with: "http://some.com"
    click_button "Share"
    within('#links') do
      page.should have_content("some.com")
    end
  end
  it 'User can see a list of links', js: true do
    Link.create! url: 'http://github.com'
    Link.create! url: 'http://heroku.com'
    visit root_path
    within('#links') do
      page.should have_content("github")
      page.should have_content("heroku")
    end
  end
  it 'When a link is clicked the count it updated', js: true do
    Link.create! url: 'http://heroku.com'
    visit root_path
    within('#links .count') {page.should have_content('0')}
    click_on 'http://heroku.com'
    visit root_path
    within('#links .count') {page.should have_content('1')}
  end
  it 'The links can view viewed on a recent order'
  it 'The links can view viewed on a popular order'

end
