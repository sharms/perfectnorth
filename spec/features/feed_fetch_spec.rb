require 'spec_helper'

describe "feed:fetch" do
  it "should parse the output correctly" do
    in_the_news = Nokogiri::HTML(in_the_news_php)
    snow_report = Nokogiri::HTML(snow_report_php)

    FeedFetch::parse_news    in_the_news
    FeedFetch::parse_general snow_report
    FeedFetch::parse_trails  snow_report
    FeedFetch::parse_carpets snow_report
 
  end
end

describe "it should parse snow_report.php" do
end
