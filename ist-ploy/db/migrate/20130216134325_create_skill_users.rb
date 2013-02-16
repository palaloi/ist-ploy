class CreateSkillUsers < ActiveRecord::Migration
  def change
    create_table :skill_users do |t|
    	t.integer :user_id
      t.integer :skill_id
      t.integer :skill_value
      t.timestamps
    end
  end
end
