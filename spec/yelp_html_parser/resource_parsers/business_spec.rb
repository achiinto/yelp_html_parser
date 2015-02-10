require 'spec_helper'

module TestBusinessContent
  def self.proper_data
    doc = Nokogiri::HTML(open("http://test.com"))
    html_content = doc.css(YelpHtmlParser::Business::BUSINESS_SEARCH_RESULTS_CSS_PATH)
    html_content.css('.search-result').first
  end

  def self.empty_data
    nil
  end
end

describe YelpHtmlParser::ResourceParsers::Business do
  before(:each) do
    header_content = { content_type: "text/html; charset=utf-8" }
    stub_request(:get, "http://test.com").to_return(body: fixture("html/yelp_search_index.html"), headers: header_content)
  end

  describe "Initialization" do
    context "with proper input" do
      business_content = nil
      before(:each) do
        business_content = TestBusinessContent.proper_data
      end

      it "instatiates a Resource Parser for Business object" do
        business_parser = described_class.new(business_content)
        expect(business_parser.class).to eq YelpHtmlParser::ResourceParsers::Business
      end

      it "assigns main and secondary attributes to parser" do
        business_parser = described_class.new(business_content)
        expect(business_parser.instance_variable_get(:@main_attributes).class).to eq Nokogiri::XML::NodeSet
        expect(business_parser.instance_variable_get(:@secondary_attributes).class).to eq Nokogiri::XML::NodeSet
      end
    end

    context "with empty as input" do
      business_content = nil
      before(:each) do
        business_content = TestBusinessContent.empty_data
      end

      it "instatiates a Resource Parser for Business object" do
        business_parser = described_class.new(business_content)
        expect(business_parser.class).to eq YelpHtmlParser::ResourceParsers::Business
      end


      it "assigns no attributes to parser" do
        business_parser = described_class.new(business_content)
        expect(business_parser.instance_variable_get(:@main_attributes)).to be_nil
        expect(business_parser.instance_variable_get(:@secondary_attributes)).to be_nil
      end
    end
  end

  describe "build_business" do
    context "with proper html data" do
      it "returns a Business resource object with data parsed frmo HTML" do
        business_content = TestBusinessContent.proper_data
        business_parser = described_class.new(business_content)
        business = business_parser.build_business
        expect(business.business_name).to eq "Car House Auto Service"
        expect(business.url).to eq "/biz/car-house-auto-service-richmond-hill"
        expect(business.avatar).to eq "//s3-media2.fl.yelpcdn.com/assets/srv0/yelp_styleguide/5f69f303f17c/assets/img/default_avatars/business_medium_square.png"
        expect(business.address).to eq "26 Colston Court, Richmond Hill, ON L4C 9Z2, Canada"
        expect(business.phone).to eq "(416) 262-9696"
      end
    end

    context "with nil object as data" do
      it "returns nil object" do
        business_parser = described_class.new(nil)
        business = business_parser.build_business
        expect(business).to be_nil
      end
    end

    context "with unexpected HTML content as data" do
      it "returns nil object" do
        business_content = double()
        allow(business_content).to receive(:css).and_return(nil)
        business_parser = described_class.new(business_content)
        business = business_parser.build_business
        expect(business).to be_nil
      end
    end
  end
end
