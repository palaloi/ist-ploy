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
  	:default_url => "no_data.png"
    
  # has_attached_file :zip 

  attr_accessible :detail, :portfolio_category_id, :title, :user_id, :photo, :zip_file

  validates_format_of :photo_file_name, :with => %r{\.(jpg|png|gif|pdf)$}i 
  # validates_format_of :zip_file_name, :with => %r{\.(zip|rar)$}i, :allow_blank => true

  validates_attachment_size :photo, :in => 0.megabytes..3.megabytes
  # validates_attachment_size :zip, :in => 0.megabytes..3.megabytes
end
