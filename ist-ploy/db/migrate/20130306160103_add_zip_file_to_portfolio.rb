class AddZipFileToPortfolio < ActiveRecord::Migration
  def up
    add_attachment :portfolios, :zip
  end

  def down
    remove_attachment :portfolios, :zip
  end
end
