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

    trails_open = 0
    trails_total = 0
    trails_status = {}
    tows_open = 0
    tows_total = 0
    tubing_lanes_open = 0
    tubing_carpets = []
    vertical_drop = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "Vertical Drop")]]')[0]
    new_snow_last_7 = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "New Snow Last 7 Days")]]')[0].text
    snow_base = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "Snow Base")]]')[0].text

    last_entry = nil
    html.xpath('//table/tr/td/p[preceding::h4[contains(text(), "Trail Status")]]') do |entry|
      case entry.text
        when /(Open|Closed)/ then trails_status[last_entry] = entry.text
        else last_entry = entry.text
      end
    end

    html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p").each do |entry|
      case entry.text
        when /^(?<tubing_lanes_open>\d+) Tubing Lanes Open/ then tubing_lanes_open = $1 
        when /^Tubing Carpet (?<tube_carpet_number>\d+): (?<status>Open|Closed)/ then tubing_carpets[$1] = $2
        when /^(?<trails_open>\d+) of (?<trails_total>\d+) Trails Open/.match(entry.text) then trails_open, trails_total = $1, $2 
        when /^(?<tows_open>\d+) of (?<tows_total>\d+) Tows\/Carpet Lifts Open/.match(entry.text) then tows_open, tows_total = $1, $2 
      end
    end
  end
end
