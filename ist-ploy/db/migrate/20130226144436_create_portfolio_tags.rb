class CreatePortfolioTags < ActiveRecord::Migration
  def change
    create_table :portfolio_tags do |t|

      t.timestamps
    end
  end
end
