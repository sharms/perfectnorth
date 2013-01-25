namespace :feed do
  desc "Parse perfectnorth.com"
  task :fetch => :environment do
    require 'feed_fetch'
    FeedFetch::all
 end
end
