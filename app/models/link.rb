require_relative '../../lib/oembed_link_parser.rb'
class Link < ActiveRecord::Base
  attr_accessible :url, :click_count, :user_id, :provider_url, :title, 
                  :description, :thumbnail_url, :provider_name, :html, :link_type

  belongs_to :user

  validates :url, presence: true, uniqueness: true, 
                  format: {with: /^(http(s?):\/\/(www\.)?|(www\.)?)\w+\.\D{2,}.*$/i }

  validates :user_id, presence: true

  before_validation :format_url, if: :url?
  before_validation :set_attribures_from_json, on: :create

  default_scope order('created_at')

  def add_click!
    increment! :click_count
  end


  private

  def format_url
    self.url = "http://#{self.url}" unless self.url.start_with?("http") 
  end

  def set_attribures_from_json 
    assign_attributes(fetch_url_info) 
  end

  def fetch_url_info
    return false unless self.url.present?
    OembedLinkParser.new(self.url).clean_response
  end

end
