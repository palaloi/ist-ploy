class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.integer :portfolio_category_id
      t.string :title
      t.text :detail

      t.timestamps
    end
  end
end
