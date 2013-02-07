class AddLocationWebSiteAbouyouAvatarToUser < ActiveRecord::Migration
  def up
  	add_column :users, :location, :string
  	add_column :users, :web_site, :string
  	add_column :users, :about_you, :text 
  	add_column :users, :avatar, :string 
  end

  def down
  	# remove_column :table_name, :column_name
  	remove_column :users, :location, :string
  	remove_column :users, :web_site, :string
  	remove_column :users, :about_you, :text 
  	remove_column :users, :avatar, :string 
  end
end
