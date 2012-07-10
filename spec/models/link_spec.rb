require 'spec_helper'
 
describe Link do
  describe 'Validations' do
    let(:link){Link.new url: 'http://google.com'}

    it 'is valid with the proper attributes' do
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
end
