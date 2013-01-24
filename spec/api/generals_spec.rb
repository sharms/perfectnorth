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
      response = JSON.parse(last_response.body)
      response.keys.each do |key|
        if general.send(key).instance_of? ActiveSupport::TimeWithZone
          response[key].should eql(general.send(key).to_json[1 .. -2])
        else
          response[key].should eql(general.send(key))
        end
      end
    end
  end
end
