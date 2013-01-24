require 'spec_helper'
require 'rack/test'

describe "/news", :type => :api do
  include Rack::Test::Methods
  context "should be viewable by all users" do
    it "json" do
      get "/news.json"
      last_response.ok?
    end
  end

  context "retrieve a single result" do
    it "has factory data accessible from a json api" do
      news = create(:news)
      get "/news/#{news.id}.json"
      json_eql_object(last_response.body, news)
    end
  end
end
