require 'nokogiri'
require 'open-uri'
require 'yelp_html_parser/business'
require 'yelp_html_parser/errors'
require 'yelp_html_parser/resource_parsers/business'
require 'yelp_html_parser/resources/business'
require 'yelp_html_parser/helpers/secondary_attributes_parser'

module YelpHtmlParser
  YELP_DOMAIN = "http://www.yelp.com/"
end
