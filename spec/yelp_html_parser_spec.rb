require 'spec_helper'

describe YelpHtmlParser do
  it 'has constant defined for the Yelp domain link' do
    expect(YelpHtmlParser::YELP_DOMAIN).to eq "http://www.yelp.com/"
  end
end
