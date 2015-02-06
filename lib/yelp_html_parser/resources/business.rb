module YelpHtmlParser
  module Resources
    class Business
      attr_accessor :business_name, :url, :avatar, :address, :phone

      def initialize
        @business_name = nil
        @url = nil
        @avatar = nil
        @address = nil
        @phone = nil
      end
    end
  end
end
