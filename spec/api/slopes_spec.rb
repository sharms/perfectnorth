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
      slope = create(:slopes)
      get "/slopes/#{slope.id}.json"
      response = JSON.parse(last_response.body)
      response.keys.each do |key|
        if slope.send(key).instance_of? ActiveSupport::TimeWithZone
          response[key].should eql(slope.send(key).to_json[1 .. -2])
        else
          response[key].should eql(slope.send(key))
        end
      end
    end
  end
end
