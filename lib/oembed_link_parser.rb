require 'rest_client'
require 'active_support/core_ext/hash'
require 'json'

class OembedLinkParser

  def initialize(url, options={})
    @url       = url
    @key       = options[:key]       || "06a1d33ad3db472ea95b7ac92683e810"
    @api_url   = options[:api_url]   || "http://api.embed.ly/1/oembed"
    @max_width = options[:max_width] || 500
    @attrs     = options[:attrs]     || ['provider_url', 'title', 'description', 
                                         'url', 'thumbnail_url', 'provider_name',
                                         'html', 'type']

  end

  def raw_response
    @raw_response ||= RestClient.get(@api_url, {params: {key: @key, url: @url, maxwidth: @max_width}})
  end

  def parsed_response
    @response ||= JSON.parse(raw_response)
  end

  def sliced_response
    @parsed_response ||= parsed_response.slice(*attrs)
  end

  def clean_response
    @clean_response ||= clean_response_helper
  end

private

  def attrs
    @attrs
  end

  def clean_response_helper
    hash = sliced_response
    hash['link_type'] = hash.delete 'type'
    hash
  end

end
