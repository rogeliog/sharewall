require File.expand_path("../../../lib/oembed.rb", __FILE__)
require 'rspec/autorun'

describe Oembed do
  describe 'fetch' do
    
    let!(:url) {"http://37signals.com/svn/posts/3203-we-cant-get-this-damn-audiovideo-conferencing-thing-to-work"}

    it 'Gets the info based on the url', :vcr do
     JSON.parse Oembed.fetch(url)
    end
  end
end
