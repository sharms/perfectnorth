require 'spec_helper'
require 'rack/test'

describe "/slopes", :type => :api do
  include Rack::Test::Methods
  context "should be viewable by all users" do
    it "json" do
      get "/slopes.json"
      last_response.ok?
    end
  end

  context "retrieve a single result" do
    it "has factory data accessible from a json api" do
      tubing_carpet = create(:tubing_carpet)
      get "/tubing_carpets/#{tubing_carpet.id}.json"
      json_eql_object(last_response.body, tubing_carpet)
    end
  end
end
