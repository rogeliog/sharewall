require 'rest_client'
require 'json'

module Oembed
  @key = "06a1d33ad3db472ea95b7ac92683e810"
  @api_url= "http://api.embed.ly/1/oembed"
  @max_width = 500

  def self.fetch(url)
    RestClient.get @api_url, {params: {key: @key, url: url, maxwidth: @max_width}}
  end

end
