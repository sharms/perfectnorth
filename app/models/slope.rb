class Slope < ActiveRecord::Base
  attr_accessible :name, :is_open
  validates :name, :presence => true
  validates :is_open, :inclusion => { :in => [true, false] }
end
