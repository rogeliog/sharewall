require 'spec_helper'

describe 'Session permisions ' do
  let(:user){stub(id: 1, name: 'Chino')}
  context 'When logged in', js: true do 
    it 'Can add a link' do
      visit root_path
      click_on 'signin'
      ->{page.find('#new_link')}.should_not raise_error
    end
  end
  context 'When logged out', js: true do 
    it  'Can not add a link' do
      visit root_path
      ->{page.find('#naew_link')}.should raise_error Capybara::ElementNotFound
    end
  end
end
