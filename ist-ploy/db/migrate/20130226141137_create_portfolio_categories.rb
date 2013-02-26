class CreatePortfolioCategories < ActiveRecord::Migration
  def change
    create_table :portfolio_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
