class General < ActiveRecord::Base
  attr_accessible :description, :new_snow_last_7, :snow_base, :tows_open, :tows_total, :trails_open, :trails_total, :tubing_lanes_open, :vertical_drop
end
