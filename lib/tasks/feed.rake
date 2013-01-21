namespace :feed do
  desc "Parse perfectnorth.com"
  task :fetch => :environment do
    require 'open-uri'

    # News items
    html = Nokogiri::HTML(open("http://perfectnorth.com/in_the_news.php"))
    titles = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/h4")
    bodies = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/p")

    titles.each_with_index do |title, index|
      puts "Creating news entries for #{title.text}: #{bodies[index].text}"
      News.create(:title => title.text, :body => bodies[index].text)
    end

    # General
    html = Nokogiri::HTML(open("http://perfectnorth.com/snow_report.php"))
    description = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p")[0].text

    trails_open = 0
    trails_total = 0
    trails_status = {}
    tows_open = 0
    tows_total = 0
    tubing_lanes_open = 0
    tubing_carpets = []
    vertical_drop = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "Vertical Drop")]]')[0].text
    new_snow_last_7 = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "New Snow Last 7 Days")]]')[0].text =~ /[Yy]es/ ? true : false
    snow_base = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "Snow Base")]]')[0].text

    last_entry = nil
    html.xpath('//table/tr/td/p[preceding::h4[contains(text(), "Trail Status")]]').each do |entry|
      case entry.text
        when /(Open|Closed)/ then trails_status[last_entry] = entry.text
        else last_entry = entry.text
      end
    end

    puts "Trail statuses: "
    puts trails_status

    html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p").each do |entry|
      case entry.text
        when /^(?<tubing_lanes_open>\d+) Tubing Lanes Open/ then tubing_lanes_open = $1 
        when /^Tubing Carpet (?<tube_carpet_number>\d+): (?<status>Open|Closed)/ then tubing_carpets[$1.to_i] = $2
        when /^(?<trails_open>\d+) of (?<trails_total>\d+) Trails Open/ then trails_open, trails_total = $1, $2; puts "$1: #{$1}, $2: #{$2}" 
        when /^(?<tows_open>\d+) of (?<tows_total>\d+) Tows\/Carpet Lifts Open/ then tows_open, tows_total = $1, $2 
      end
    end

    puts "Creating general entry"
    General.create(:description => description, 
                   :new_snow_last_7 => new_snow_last_7,
                   :snow_base => snow_base,
                   :tows_open => tows_open,
                   :tows_total => tows_total,
                   :trails_open => trails_open,
                   :trails_total => trails_total,
                   :tubing_lanes_open => tubing_lanes_open,
                   :vertical_drop => vertical_drop)

    trails_status.each do |name, status|
      if status =~ /Open/ then status = true else status = false end
      puts "Creating #{name}: #{status}"
      Slope.create(:name => name, :status => status)
    end

    tubing_carpets.each_with_index do |status, index|
      if status =~ /Open/ then status = true else status = false end
      puts "Creating tubing_carpet #{index + 1}: #{status}"
      TubingCarpet.create(:number => (index + 1), :status => status)
    end
  end
end
