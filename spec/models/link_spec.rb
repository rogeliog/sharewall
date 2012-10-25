require File.expand_path("../../../lib/oembed.rb", __FILE__)
require 'rspec/autorun'
require 'spec_helper'

describe Link do
  let(:link){Link.create url: 'http://google.com', user_id: 1}
  let!(:response){
    "{\"provider_url\": \"http://www.google.com\", \"description\": \"Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for.\", \"title\": \"Google\", \"url\": \"http://www.google.com\", \"thumbnail_width\": 275, \"thumbnail_url\": \"http://www.google.com/intl/en_ALL/images/srpr/logo1w.png\", \"version\": \"1.0\", \"provider_name\": \"Google\", \"type\": \"link\", \"thumbnail_height\": 95}"
  }
  before { Oembed.stub!(:fetch) { response } } 
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
      it 'with a badly formated url' do
        link.url = "notvalid"
        link.should_not be_valid
      end
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

  describe 'fetch_url_info' do
    context 'With no url' do
      it 'Returns' do
        link.url = nil
        link.fetch_url_info.should == false

      end
    end
    context 'With a url' do
      it 'Calls the Oembed.fetch with the url' do
        Oembed.should_receive(:fetch).with(link.url)
        link.fetch_url_info
      end
    end
  end
  describe '.set_attribures_from_json' do
    context 'When false fetch_url_info' do
      it 'Does not set any attributes'
    end
    context 'When false fetch_url_info' do
      let!(:json){JSON.parse response}
      it 'Sets the title' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.title.should == "Google"
      end
      it 'Sets the provider_url' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.provider_url.should == "http://www.google.com"
      end
      it 'Sets the provider_name' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.provider_name.should == "Google"
      end
      it 'Sets the link_type' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.link_type.should == "link"
      end
      it 'Sets the description' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.description.should include "Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for"
      end
      it 'Sets the thumbnail_url' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.thumbnail_url.should == "http://www.google.com/intl/en_ALL/images/srpr/logo1w.png"
      end
      it 'Sets the provider_name' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.provider_name.should == "Google"
      end
      it 'Sets the html' do
        link.should_receive(:fetch_url_info){response}
        link.should_receive(:html=)
        link.set_attribures_from_json
      end
    end

  end
end
