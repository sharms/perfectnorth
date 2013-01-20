class News < ActiveRecord::Base
  attr_accessible :body, :title
  validates :title, :body, :presence => true
end
