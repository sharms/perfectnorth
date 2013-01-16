namespace :feed do
  desc "Parse perfectnorth.com"
  task :fetch => :environment do
    require 'open-uri'

    # News items
    html = Nokogiri::HTML(open("http://perfectnorth.com/in_the_news.php"))
    titles = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/h4")
    bodies = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/p")

    # General
    html = Nokogiri::HTML(open("http://perfectnorth.com/snow_report.php"))
    general = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p")[0].text

    # Tubing Park
    lanes_open = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p")[2].
      text.split.first

  end

end
