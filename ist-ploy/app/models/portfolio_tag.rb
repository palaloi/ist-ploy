class PortfolioTag < ActiveRecord::Base
	belongs_to :tag 
	belongs_to :portfolio
  # attr_accessible :title, :body
  attr_accessible :tag, :portfolio
end
