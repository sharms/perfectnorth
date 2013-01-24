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
end
