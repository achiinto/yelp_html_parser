module YelpHtmlParser
  module ResourceParsers
    class Business

      def initialize(business_data)
        @main_attributes =  business_data.css('.main-attributes')
        @secondary_attributes =  business_data.css('.secondary-attributes')
      end

      def build_business
        business = YelpHtmlParser::Resources::Business.new
        business.business_name = @main_attributes.css('.biz-name').first.children[0].to_s
        business.url = @main_attributes.css('.biz-name').first.attributes["href"].value
        business.avatar = @main_attributes.css('.photo-box-img').first.attributes['src'].value
        business.address = @secondary_attributes.first.css('address').children.to_s
        business.phone = @secondary_attributes.first.css('.biz-phone').children.to_s
        business
      end
    end
  end
end
