class PortfolioCategory < ActiveRecord::Base
	has_many :portfolios
  attr_accessible :name
end
