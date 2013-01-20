class Slope < ActiveRecord::Base
  attr_accessible :name, :status
  validates :name, :presence => true
  validates :status, :inclusion => { :in => [true, false] }
end
