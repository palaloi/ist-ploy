class SkillUser < ActiveRecord::Base
  
  belongs_to :user 
  belongs_to :skill 
  attr_accessible :user_id, :skill_id, :skill_value
  validates :skill_value, :numericality => true, :allow_nil => true 
  validates_numericality_of :skill_value, {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
end
