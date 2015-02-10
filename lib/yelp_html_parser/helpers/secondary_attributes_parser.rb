module YelpHtmlParser
  module Helpers
    class SecondaryAttributesParser
      def initialize(attribute)
        @attribute = attribute
      end

      def parse
        result = /(?:[^\n\s]).*(?=\n)/.match(@attribute).to_s
        result.gsub("<br>",", ")
      end
    end
  end
end
