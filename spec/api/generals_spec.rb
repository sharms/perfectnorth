require 'spec_helper'
require 'rack/test'

describe "/general", :type => :api do
  include Rack::Test::Methods
  context "should be viewable by all users" do
    it "json" do
      get "/general.json"
      last_response.ok?
    end
  end

  context "retrieve a single result" do
    it "has factory data accessible from a json api" do
      general = create(:general)
      get "/general/#{general.id}.json"
      json_eql_object(last_response.body, general)
    end
  end

end
