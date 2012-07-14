class Link < ActiveRecord::Base
  attr_accessible :url, :click_count

  validates :url, presence: true, uniqueness: true, format: {with: /^(http(s?):\/\/(www\.)?|(www\.)?)\w+\.\D{2,}.*$/i }

  before_validation :format_url, if: :url?

  def add_click!
    increment! :click_count
  end

  def format_url
    self.url = "http://#{self.url}" unless self.url.start_with?("http") 
  end
end
