require 'spec_helper'

describe YelpHtmlParser::ResourceParsers::Business do
  business_content = nil

  before(:each) do
    header_content = { content_type: "text/html; charset=utf-8" }
    stub_request(:get, "http://test.com").to_return(body: fixture("html/yelp_search_index.html"), headers: header_content)
    doc = Nokogiri::HTML(open("http://test.com"))
    html_content = doc.css(YelpHtmlParser::Business::BUSINESS_SEARCH_RESULTS_CSS_PATH)
    business_content = html_content.css('.search-result').first
  end

  describe "Initialization" do
    it "instatiates a Resource Parser for Business object" do
      business_parser = described_class.new(business_content)
      expect(business_parser.class).to eq YelpHtmlParser::ResourceParsers::Business
    end
  end

  describe "build_business" do
    context "with proper html data" do
      it "returns a Business resource object with data parsed frmo HTML" do
        business_parser = described_class.new(business_content)
        business = business_parser.build_business
        expect(business.business_name).to eq "Car House Auto Service"
        expect(business.url).to eq "/biz/car-house-auto-service-richmond-hill"
        expect(business.avatar).to eq "//s3-media2.fl.yelpcdn.com/assets/srv0/yelp_styleguide/5f69f303f17c/assets/img/default_avatars/business_medium_square.png"
        expect(business.address).to eq "\n            26 Colston Court<br>Richmond Hill, ON L4C 9Z2<br>Canada\n        "
        expect(business.phone).to eq "\n        (416) 262-9696\n    "
      end
    end
  end
end
