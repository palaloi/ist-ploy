class Tag < ActiveRecord::Base
	has_many :portfolio_tags
	has_many :portfolios, :through => :portfolio_tags
  attr_accessible :name
end
