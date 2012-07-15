require File.expand_path("../../../lib/oembed.rb", __FILE__)
require 'rspec/autorun'
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
      let!(:response){
      "{\"provider_url\": \"http://www.google.com\", \"description\": \"Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for.\", \"title\": \"Google\", \"url\": \"http://www.google.com\", \"thumbnail_width\": 275, \"thumbnail_url\": \"http://www.google.com/intl/en_ALL/images/srpr/logo1w.png\", \"version\": \"1.0\", \"provider_name\": \"Google\", \"type\": \"link\", \"thumbnail_height\": 95}"
      }
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
      it 'Sets the type' do
        link.should_receive(:fetch_url_info){response}
        link.set_attribures_from_json
        link.type.should == "link"
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
