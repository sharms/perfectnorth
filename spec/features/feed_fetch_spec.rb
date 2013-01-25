#!/usr/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe "feed:fetch" do
  it "should parse the snow_report.php for general information" do
    snow_report = Nokogiri::HTML(snow_report_php)
    FeedFetch::parse_general(snow_report).should eq({:description=>"We will be open for skiing, snowboarding today from 9:30am-9:30pm. Snow tubing will open at 1pm. Definitely a top 10 day of the season today. Tons of new snow and sun to start the day. We have made snow non stop since Monday evening some of that time at very cold temperatures. Lots of big mounds of snow lots of powdery snow, just lots of snow. The most and best snow we have had in two seasons!", :new_snow_last_7=>true, :snow_base=>"30-72\"", :tows_open=>"6", :tows_total=>"6", :trails_open=>"23", :trails_total=>"23", :tubing_lanes_open=>"23", :vertical_drop=>"400'"})
  end

  it "should parse the in_the_news.php for news" do
    in_the_news = Nokogiri::HTML(in_the_news_php)
    FeedFetch::parse_news(in_the_news).should eq([{:title=>"WOMEN'S SKI CLINIC - JAN 25", :body=>"This ski clinic is for women with intermediate through advanced skill levels. The clinic is taught by women who want to share their love of the sport with other women. Clinic lasts 9:30am - 3:00pm. Cost $65. Does not include rental equipment or lift ticket. Registration required."}, {:title=>"MEN'S ALL MOUNTAIN CLINIC - JAN 25", :body=>"This event for men is a high energy clinic for intermediate to advanced level skiers. Clinic lasts from 9:30am - 3:00pm, and costs $65. Advanced registration in required. Registration fee does not include lift ticket or rental equipment."}, {:title=>"NEW YEAR'S EVE RAIL JAM RESULTS", :body=>"Congrats to these winners of our annual New Year's Eve Rail Jam! \r\nPRO SKI Division:\r\n1. Brad Kohlmeier  2. Andy Hall  3. Kyle Taylor.\r\nPRO SNOWBOARD Divison:\r\n1. Davis Church  2. Ryan Walter  3. Craig Edwards.\r\nAMATEUR SKI Division:\r\n1. Henry Luchon  2. Freddy Mazza  3. Brad Stoelting.\r\nAMATEUR SNOWBOARD Divison:\r\n1. Kyle Chrisman  2. Teddy Bertaux  3. Joe Brush."}, {:title=>"ACCEPTING GROUP RESERVATIONS", :body=>"Bring a group of 15 or more for skiing/snowboarding and snow tubing and receive discounted pricing. It's an exciting winter activity for all ages! Reserve your date soon....no deposit required!"}, {:title=>"PHOTO GALLERY", :body=>"Check out photos from last season, and from the 3 Mud-Stash runs held over the summer. Lots of fun represented here!"}])
  end

  it "should parse the snow_report.php for trail information" do
    snow_report = Nokogiri::HTML(snow_report_php)
    FeedFetch::parse_trails(snow_report).should eq({"Broadway"=>true, "Intermission"=>true, "Call Back"=>true, "Runway"=>true, "Cat Walk"=>true, "Special Effects"=>true, "Rehearsal"=>true, "Center Stage"=>true, "Audition"=>true, "Deception"=>true, "Backstage"=>true, "Encore"=>true, "Clyde's Super Slide"=>true, "Lower Showtime"=>true, "Hoyt Connection"=>true, "Jam Session"=>true, "Ski Wiz"=>true, "Hollywood"=>true, "The Far Side"=>true, "Showtime"=>true, "The Meadow"=>true, "Tuff Enuff"=>true})
  end

  it "should parse snow_report.php for carpet information" do
    snow_report = Nokogiri::HTML(snow_report_php)
    FeedFetch::parse_carpets(snow_report).should eq([nil, true, true])
  end
 

end
