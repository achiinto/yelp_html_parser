module YelpHtmlParser
  module ResourceParsers
    class Business

      def initialize(business_data)
        return unless business_data
        @main_attributes =  business_data.css('.main-attributes')
        @secondary_attributes =  business_data.css('.secondary-attributes')
      end

      def build_business
        return nil unless @main_attributes
        business = YelpHtmlParser::Resources::Business.new
        business.business_name = @main_attributes.css('.biz-name').first.children[0].to_s
        business.url = @main_attributes.css('.biz-name').first.attributes["href"].value
        business.avatar = @main_attributes.css('.photo-box-img').first.attributes['src'].value
        address_string = @secondary_attributes.first.css('address').children.to_s
        phone_string = @secondary_attributes.first.css('.biz-phone').children.to_s
        business.address = YelpHtmlParser::Helpers::SecondaryAttributesParser.new(address_string).parse
        business.phone = YelpHtmlParser::Helpers::SecondaryAttributesParser.new(phone_string).parse
        business
      end
    end
  end
end
