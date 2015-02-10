require 'spec_helper'

describe YelpHtmlParser::Helpers::SecondaryAttributesParser do
  describe "parser" do
    context "with Yelp HTML format of address" do
      it "returns address without linebreak, leading spaces and trailing spaces" do
        result = described_class.new("\n         26 Colston Court<br>Richmond Hill, ON L4C 9Z2<br>Canada\n      ").parse
        expect(result).to eq "26 Colston Court, Richmond Hill, ON L4C 9Z2, Canada"
      end
    end

    context "with Yelp HTML format of phone" do
      it "returns address without linebreak, leading spaces and trailing spaces" do
        result = described_class.new("\n         (416) 262-9696\n      ").parse
        expect(result).to eq "(416) 262-9696"
      end
    end
  end
end
