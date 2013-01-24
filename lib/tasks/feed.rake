namespace :feed do
  desc "Parse perfectnorth.com"
  task :fetch => :environment do
    require 'open-uri'
    require 'feed_fetch'

    in_the_news = Nokogiri::HTML(open("http://perfectnorth.com/in_the_news.php"))
    snow_report = Nokogiri::HTML(open("http://perfectnorth.com/snow_report.php"))

    FeedFetch::parse_news    in_the_news
    FeedFetch::parse_general snow_report
    FeedFetch::parse_trails  snow_report
    FeedFetch::parse_carpets snow_report
 end
end
