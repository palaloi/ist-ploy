class AddPhotoToPortfolio < ActiveRecord::Migration
  def change
  	add_column :portfolios, :photo_file_name, :string
    add_column :portfolios, :photo_content_type, :string
    add_column :portfolios, :photo_file_size, :integer
  end
end
