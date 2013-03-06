require 'spec_helper_model'

describe Link do
  let(:link){Link.create url: 'http://google.com', user_id: 1}
  let!(:response){{"provider_url"=>"http://www.google.com", "title"=>"Google", 
    "description"=>"Search the world", "url"=>"http://www.google.com", 
    "thumbnail_url"=>"http://www.google.com/logo1w.png", "provider_name"=>"Google",
    "html"=>"some html", "link_type"=>"link"}}
  before { OembedLinkParser.any_instance.stub(:clean_response) { response } } 

  describe 'Validations' do
    context 'is valid' do
      it 'with the proper attributes' do
        link.valid?
        link.should be_valid
      end
    end
    context 'is invalid' do
      it 'without a url' do
        link.url = nil
        link.should_not be_valid
      end

      it 'without a user_id' do
      link.user_id = nil
      link.should_not be_valid
    end
    it 'with a duplicated url' do
      Link.create(url: link.url).should_not be_valid
    end
    # Validations are commented
    # TODO: Seed if they should be reinstated
    # it 'with a badly formated url' do
    #   link.url = "notvalid"
    #   link.should_not be_valid
    # end
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
    link.send(:format_url)
    link.url.should == 'http://github.com'
  end
  it 'Does not adds it when it is no required' do
    link.url = 'http://github.com'
    link.send(:format_url)
    link.url.should == 'http://github.com'
  end
end

describe '.set_attribures_from_json' do
  context 'When false fetch_url_info' do
    before{ link.send :set_attribures_from_json }
    it 'Sets the title' do
      link.title.should == "Google"
    end
    it 'Sets the provider_url' do
      link.provider_url.should == "http://www.google.com"
    end
    it 'Sets the provider_name' do
      link.provider_name.should == "Google"
    end
    it 'Sets the link_type' do
      link.link_type.should == "link"
    end
    it 'Sets the description' do
      link.description.should include "Search the world"
    end
    it 'Sets the thumbnail_url' do
      link.thumbnail_url.should == "http://www.google.com/logo1w.png"
    end
    it 'Sets the provider_name' do
      link.provider_name.should == "Google"
    end
    it 'Sets the html' do
      link.should_receive(:html=)
      link.send(:set_attribures_from_json)
      end
    end

  end
end
