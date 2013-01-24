FactoryGirl.define do
  factory :general do
    description "Today the park is looking good"
    new_snow_last_7 true
    snow_base "34\""
    tows_open 23
    tows_total 23
    trails_open 24
    trails_total 25
    tubing_lanes_open 3
    vertical_drop 400
  end

  factory :news do
    title "this is news"
    body "very detailed news"
  end

  factory :slope do
  end

  factory :tubing_carpet do
  end
end
