namespace :feed do
  desc "Parse perfectnorth.com"
  task :fetch => :environment do
    require 'open-uri'

    in_the_news = Nokogiri::HTML(open("http://perfectnorth.com/in_the_news.php"))
    snow_report = Nokogiri::HTML(open("http://perfectnorth.com/snow_report.php"))

    parse_news    in_the_news
    parse_general snow_report
    parse_trails  snow_report
    parse_carpets snow_report
 end

  # Parse the news page, with no specific timestamps attached (their format, not mine!)
  def parse_news(html)
    titles = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/h4")
    bodies = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/p")

    titles.each_with_index do |title, index|
      puts "Creating news entries for #{title.text}: #{bodies[index].text}"
      News.create(:title => title.text, :body => bodies[index].text)
    end
  end

  # Parse out the general slope statistics - the page is laid out using all tables and paragraphs
  # with no classes or ids to key off of, so this approach uses xpath and regexs to best guess
  def parse_general(html)
    description = html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p")[0].text

    trails_open       = 0
    trails_total      = 0
    tows_open         = 0
    tows_total        = 0
    tubing_lanes_open = 0

    # Xpaths
    vertical_drop = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "Vertical Drop")]]')[0].text
    new_snow_last_7 = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "New Snow Last 7 Days")]]')[0].text =~ /[Yy]es/ ? true : false
    snow_base = html.xpath('//table/tr/td/p[preceding::p[contains(text(), "Snow Base")]]')[0].text

    html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p").each do |entry|
      case entry.text
        when /^(?<tubing_lanes_open>\d+) Tubing Lanes Open/ then tubing_lanes_open = $1 
        when /^(?<trails_open>\d+) of (?<trails_total>\d+) Trails Open/ then trails_open, trails_total = $1, $2; puts "$1: #{$1}, $2: #{$2}" 
        when /^(?<tows_open>\d+) of (?<tows_total>\d+) Tows\/Carpet Lifts Open/ then tows_open, tows_total = $1, $2 
      end
    end

    General.create(:description => description, 
                   :new_snow_last_7 => new_snow_last_7,
                   :snow_base => snow_base,
                   :tows_open => tows_open,
                   :tows_total => tows_total,
                   :trails_open => trails_open,
                   :trails_total => trails_total,
                   :tubing_lanes_open => tubing_lanes_open,
                   :vertical_drop => vertical_drop)
  end

  # Line up slope name with Open or Closed
  def parse_trails(html)
    trails_status = {}
    last_entry = nil
    html.xpath('//table/tr/td/p[preceding::h4[contains(text(), "Trail Status")]]').each do |entry|
      if entry.text =~ /(Open|Closed)/ 
        trails_status[last_entry] = ($1 == "Open") ? true : false
      else 
        last_entry = entry.text
      end
    end

    trails_status.each do |name, is_open|
      puts "Creating #{name}: #{is_open}"
      Slope.create(:name => name, :is_open => is_open)
    end
  end

  # Search for text "Tubing Carpet #: Open" or closed and put that in an array
  def parse_carpets(html)
    tubing_carpets = []

    html.xpath("//div[@role = 'main']/div[@id = 'intLeft']/table/tr/td/p").each do |entry|
      if entry.text =~ /^Tubing Carpet (?<tube_carpet_number>\d+): (?<is_open>Open|Closed)/
        tubing_carpets[$1.to_i] = ($2 == "Open") ? true : false
      end
    end

    tubing_carpets.from(1).each_with_index do |is_open, index|
      puts "Creating tubing_carpet #{index + 1}: #{is_open}"
      TubingCarpet.create(:number => (index + 1), :is_open => is_open)
    end
  end
end
