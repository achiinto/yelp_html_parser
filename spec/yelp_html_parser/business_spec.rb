require 'spec_helper'

describe YelpHtmlParser::Business do
  before(:each) do
    header_content = { content_type: "text/html; charset=utf-8" }
    stub_request(:get, YelpHtmlParser::YELP_DOMAIN + "search?start=2&l=g:-79.42,43.85,-79.43,43.84")
      .to_return(body: fixture("html/yelp_search_index.html"), headers: header_content)
  end

  describe "search" do
    it "makes request to Yelp search url with given params" do
      described_class.search(-79.42, 43.85, -79.43, 43.84, 2)
      expect(a_request(:get, YelpHtmlParser::YELP_DOMAIN + "search?start=2&l=g:-79.42,43.85,-79.43,43.84"))
        .to have_been_made.once
    end

    it "parses search result into business objects" do
      result = described_class.search(-79.42, 43.85, -79.43, 43.84, 2)
      expect(result.size).to eq(10)
      expect(result.first.class).to eq(YelpHtmlParser::Resources::Business)
    end
  end
end
