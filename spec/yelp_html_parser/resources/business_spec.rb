require 'spec_helper'

describe YelpHtmlParser::Resources::Business do
  describe "attributes" do
    it "can assign and access business attributes" do
      object = described_class.new
      expect(object.instance_variable_get(:@business_name)).to be_nil
      expect(object.instance_variable_get(:@url)).to be_nil
      expect(object.instance_variable_get(:@avatar)).to be_nil
      expect(object.instance_variable_get(:@address)).to be_nil
      expect(object.instance_variable_get(:@phone)).to be_nil

      object.business_name = "test name"
      object.url = "test url"
      object.avatar = "test avatar"
      object.address = "test address"
      object.phone = "test phone"

      expect(object.instance_variable_get(:@business_name)).to eq "test name"
      expect(object.instance_variable_get(:@url)).to eq "test url"
      expect(object.instance_variable_get(:@avatar)).to eq "test avatar"
      expect(object.instance_variable_get(:@address)).to eq "test address"
      expect(object.instance_variable_get(:@phone)).to eq "test phone"      
    end
  end
end
