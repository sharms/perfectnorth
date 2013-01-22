class Slope < ActiveRecord::Base
  attr_accessible :name, :open
  validates :name, :presence => true
  validates :open, :inclusion => { :in => [true, false] }
end
