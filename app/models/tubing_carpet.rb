class TubingCarpet < ActiveRecord::Base
  attr_accessible :number, :status
  validates :status, :inclusion => { :in => [ true, false ] }
  validates :number, :presence => true
  validates :number, :numericality => { :only_integer => true }
end
