class Skill < ActiveRecord::Base
	has_many :skill_users
  has_many :users, :through => :skill_users
  attr_accessible :description, :name
end
