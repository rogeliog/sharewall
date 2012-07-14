require 'spec_helper'
 
describe Link do
  let(:link){Link.new url: 'http://google.com'}
  describe 'Validations' do
    it 'is valid with the proper attributes' do
      link.valid?
      puts link.errors.full_messages
      link.should be_valid
    end
    it 'is invalid without a url' do
      link.url = nil
      link.should_not be_valid
    end
    it 'is invalid with a duplicated url' do
      Link.create url: link.url
      link.should_not be_valid
    end
    it 'is invalid badly formated url' do
      link.url = "notvlaiss"
      link.should_not be_valid
    end
  end

  describe '.add_click' do
    it 'adds one to the click count' do
      lambda { link.add_click!}.should change(link, :click_count).by(1)
    end
  end

  describe '.format_url' do
    it 'Adds the http when required' do
      link.url = 'github.com'
      link.format_url
      link.url.should == 'http://github.com'
    end
    it 'Does not adds it when it is no required' do
      link.url = 'http://github.com'
      link.format_url
      link.url.should == 'http://github.com'
    end

  end
end
