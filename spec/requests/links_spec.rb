require 'spec_helper'

describe 'User Link wall' do
  let(:user){stub(id: 1, name: 'Chino')}
  before do
    VCR.use_cassette(:github_link)    { @github = Link.create!( 
                                                  url: 'http://github.com',
                                                  user_id: user.id)}
    VCR.use_cassette(:heroku_link)    { @heroku = Link.create!(
                                                  url: 'http://heroku.com',
                                                  user_id: user.id)}
    VCR.use_cassette(:peepcode_link)  { @peepcode = Link.create!(
                                                  url: 'http://peepcode.com',
                                                  user_id: user.id)}
   visit root_path 
   click_on 'signin'
  end

  it 'User can add a new link', js: true do
    VCR.use_cassette(:github_link) do
      visit root_path
      fill_in "new_link_url", with: "http://github.com"
      click_button "Share"
      within('#links') do
        page.should have_content(Link.first.title)
      end
    end
  end
  it 'User can see a list of links', js: true do
    visit root_path
    within('#links') do
      page.should have_content(@github.title)
      page.should have_content(@heroku.title)
    end
  end
  it 'When a link is clicked the count it updated', js: true do
    Link.destroy_all
    VCR.use_cassette(:google_link) { @l = Link.create! url: 'http://google.com',
                                                       user_id: user.id}
    visit root_path
    within('#links .count') {page.should have_content('0')}
    click_on @l.title
    visit root_path
    within('#links .count') {page.should have_content('1')}
  end

  it 'The links can view viewed on a recent order', js: true do
    visit root_path
    within("#links") do
      actual_order = page.all('.link a').collect(&:text).map{|link| link.gsub(/\n\d+/, '')}
      actual_order.should == [@peepcode.title,@heroku.title, @github.title]
    end
  end
  it 'The links can view viewed on a popular order', js: true do
    @github.update_attribute :click_count, 20
    @heroku.update_attribute :click_count, 15
    @peepcode.update_attribute :click_count, 30
    visit root_path
    click_on 'Popular'
    within("#links") do
      actual_order = page.all('.link a').collect(&:text).map{|link| link.gsub(/\n\d+/, '')}
      actual_order.should == [@peepcode.title, @github.title, @heroku.title]
    end

  end

  it 'User can change between recent and popular order', js: true do
    @github.update_attribute :click_count, 20
    @heroku.update_attribute :click_count, 15
    @peepcode.update_attribute :click_count, 30
    visit root_path
    click_on 'Recent'
    within("#links") do
      actual_order = page.all('.link a').collect(&:text).map{|link| link.gsub(/\n\d+/, '')}
      actual_order.should == [@peepcode.title, @heroku.title, @github.title]
    end
    click_on 'Popular'
    within("#links") do
      actual_order = page.all('.link a').collect(&:text).map{|link| link.gsub(/\n\d+/, '')}
      actual_order.should == [@peepcode.title, @github.title, @heroku.title]
    end

  end

end
