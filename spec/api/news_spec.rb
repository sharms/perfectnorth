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
      response = JSON.parse(last_response.body)
      response.keys.each do |key|
        if news.send(key).instance_of? ActiveSupport::TimeWithZone
          response[key].should eql(news.send(key).to_json[1 .. -2])
        else
          response[key].should eql(news.send(key))
        end
      end
    end
  end
end
