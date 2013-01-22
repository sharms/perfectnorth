class TubingCarpet < ActiveRecord::Base
  attr_accessible :number, :is_open
  validates :is_open, :inclusion => { :in => [ true, false ] }
  validates :number, :presence => true
  validates :number, :numericality => { :only_integer => true }
end
