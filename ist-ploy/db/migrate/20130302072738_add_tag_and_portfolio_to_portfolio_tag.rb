class AddTagAndPortfolioToPortfolioTag < ActiveRecord::Migration
  def up
    add_column :portfolio_tags, :tag_id, :integer
    add_column :portfolio_tags, :portfolio_id, :integer
  end

  def down
    remove_column :portfolio_tags, :tag_id
    remove_column :portfolio_tags, :portfolio_id
  end
end
