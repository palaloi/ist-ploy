class Portfolio < ActiveRecord::Base
	belongs_to :portfolio_category
	has_many :portfolio_tags
	has_many :tags, :through => :portfolio_tags
	has_attached_file :photo,
  	:styles => {
      :thumb=> "100x100#",
      :small  => "400x400>",
      :medium  => "800x800>"
  	},
  	:default_url => "missing.png"
  attr_accessible :detail, :portfolio_category_id, :title, :user_id, :photo
end
