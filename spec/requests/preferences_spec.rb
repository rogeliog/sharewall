require 'spec_helper'

describe 'User Preferences' do
  before do
   visit root_path 
   click_on 'signin'
   click_link "rogeliog"
  end

  it 'shows email and default preferences to the user ', js: true do
    find('#user_email').value.should == 'rogelio@innku.com'
    checkbox = find('#user_preferences_newsletter').should be_checked
  end

  it 'can change the e-mail of the user', js: true do
    fill_in('E-mail', with: 'adrian@innku.com')
    click_button("Save")
    page.should have_css('.alert-success')
    click_link "rogeliog"
    find('#user_email').value.should == 'adrian@innku.com'
  end

  it 'can edit the users e-mail preferences', js: true do
    uncheck('user_preferences_newsletter')
    click_button("Save")
    page.should have_css('.alert-success')
    click_link "rogeliog"
    checkbox = find('#user_preferences_newsletter').should_not be_checked
  end

  it 'validates user e-mail input', js: true do
    fill_in('E-mail', with: 'fakeemail.com')
    click_button("Save")
    page.should have_css('.alert-error', visible: true)
  end

end
