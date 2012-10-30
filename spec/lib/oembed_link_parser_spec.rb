require_relative '../../lib/oembed_link_parser.rb'
require 'spec_helper_unit'

describe OembedLinkParser do
  subject{OembedLinkParser.new "http://google.com"}
  let!(:response){
    "{\"provider_url\": \"http://www.google.com\", \"description\": \"Search the world\",
       \"title\": \"Google\", \"url\": \"http://www.google.com\", \"thumbnail_width\": 275,
       \"thumbnail_url\": \"http://www.google.com/logo1w.png\", \"version\": \"1.0\",
       \"provider_name\": \"Google\", \"type\": \"link\", \"thumbnail_height\": 95, 
       \"html\": \"some html\"}"
  }

  before { RestClient.stub(:get) {response} } 

  it 'Fethes the url info from the Embedly api' do
    subject.raw_response.should == response
  end
  it 'Parses it to json' do
    subject.parsed_response.should == JSON.parse(response)
  end
  it 'Just uses the necesary keys' do
    keys = ['provider_url', 'title', 'description', 'url', 
            'thumbnail_url', 'provider_name', 'html', 'type']
    subject.sliced_response.keys.should == keys
  end
  it 'Changes the type for link_type to avoid issues with active record' do
    keys = ['provider_url', 'title', 'description', 'url', 
            'thumbnail_url', 'provider_name', 'html', 'link_type']
    subject.clean_response.keys.should == keys
  end
end
