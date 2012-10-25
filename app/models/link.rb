include Oembed

class Link < ActiveRecord::Base
  attr_accessible :url, :click_count

  validates :url, presence: true, uniqueness: true, format: {with: /^(http(s?):\/\/(www\.)?|(www\.)?)\w+\.\D{2,}.*$/i }

  before_validation :format_url, if: :url?
  before_validation :set_attribures_from_json, on: :create

  default_scope order('created_at')

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
    special_attr.each { |k,v| self.public_send "#{v}=".to_sym, json[k] }
  end

  private

  def attrs
    [ 'provider_url', 'provider_name', 'title', 'description', 'url', 'thumbnail_url', 'provider_name', 'html']
  end

  def special_attr
    {'type' => 'link_type'}
  end
end
