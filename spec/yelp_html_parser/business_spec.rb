require 'spec_helper'

describe YelpHtmlParser::Business do
  header_content = { content_type: "text/html; charset=utf-8" }

  describe "search" do
    context "with success" do
      before(:each) do
        stub_request(:get, YelpHtmlParser::YELP_DOMAIN + "search?start=2&l=g:-79.42,43.85,-79.43,43.84")
          .to_return(body: fixture("html/yelp_search_index.html"), headers: header_content)
      end

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

    context "with failure" do
      before(:each) do
        stub_request(:get, YelpHtmlParser::YELP_DOMAIN + "search?start=0&l=g:-79.42,43.85,-79.43,43.84")
          .to_return(status: [503])
      end

      it "raise error" do
        expect { described_class.search(-79.42, 43.85, -79.43, 43.84, 0) }.to raise_error(YelpHtmlParser::Errors::NetworkError)
      end
    end
  end
end
