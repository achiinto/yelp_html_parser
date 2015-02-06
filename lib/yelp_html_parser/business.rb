module YelpHtmlParser
  class Business
    BUSINESS_SEARCH_RESULTS_CSS_PATH = '#super-container > div.container.indexed-biz-archive > div.clearfix.layout-block.layout-a.scroll-map-container.search-results-block > div.column.column-alpha > div > div.content > ul > li'

    def self.search(sw_latitude, sw_longitude, ne_latitude, ne_longitude, start_index = 0)
      link = YelpHtmlParser::YELP_DOMAIN +
        "search?start=#{ start_index }&l=g:#{ sw_latitude },#{ sw_longitude },#{ ne_latitude },#{ ne_longitude }"
      user_agent = "googlebot"
      options = { 'User-Agent' => 'Googlebot', 'read_timeout' => '20' }
      doc = Nokogiri::HTML(open(link, options))
      content = doc.css(BUSINESS_SEARCH_RESULTS_CSS_PATH)
      content.css('.search-result').map do |business_content|
        YelpHtmlParser::ResourceParsers::Business.new(business_content).build_business
      end
      # need error handling in case of 503 error.
    end
  end
end
