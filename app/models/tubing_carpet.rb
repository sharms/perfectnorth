class TubingCarpet < ActiveRecord::Base
  attr_accessible :number, :status
  valides :status, :inclusion => { :in => [ true, false ] }
  validates :number, :presence => true
  validates :number, :numericality => { :only_integer => true }
end
