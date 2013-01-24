module PerfectnorthWebsite
  def in_the_news_php
    File.open('./spec/web/in_the_news.php', 'r').read
  end

  def snow_report_php
    File.open('./spec/web/snow_report.php', 'r').read
  end
end
