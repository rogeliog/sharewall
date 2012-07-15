require 'spec_helper'

describe Oembed do
  describe 'fetch' do
    
    let!(:url) {"http://37signals.com/svn/posts/3203-we-cant-get-this-damn-audiovideo-conferencing-thing-to-work"}

    it 'Gets the info based on the url' do
      VCR.use_cassette(:oembed) do
        lambda { JSON.parse Oembed.fetch(url) }.should_not raise_error
      end
    end
  end
end
