require 'spec_helper'

describe "Homepages" do
  it "has a homepage which describes the usage and description" do
    visit root_path
    page.should have_content('curl')
    page.should have_content('Perfect North')
  end
end
