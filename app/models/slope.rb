class Slope < ActiveRecord::Base
  attr_accessible :name, :status
  validates :name, :status, :presence => true
end
