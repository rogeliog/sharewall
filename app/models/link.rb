include Oembed

class Link < ActiveRecord::Base
  attr_accessible :url, :click_count

  validates :url, presence: true, uniqueness: true, format: {with: /^(http(s?):\/\/(www\.)?|(www\.)?)\w+\.\D{2,}.*$/i }

  before_validation :format_url, if: :url?
  before_create :set_attribures_from_json

  def add_click!
    increment! :click_count
  end

  def format_url
    self.url = "http://#{self.url}" unless self.url.start_with?("http") 
  end

  def fetch_url_info
    return false unless self.url.present?
    Oembed.fetch(self.url)
  end

  def set_attribures_from_json 
    json = JSON.parse(fetch_url_info)
    attrs.each {|a| self.public_send "#{a}=".to_sym, json[a]}
  end

  private

  def attrs
    [ 'provider_url', 'provider_name', 'type', 'title', 'description', 'url', 'thumbnail_url', 'provider_name', 'html']
  end
end
