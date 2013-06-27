class CreateFinancialBudgets < ActiveRecord::Migration
  def change
    create_table :financial_budgets do |t|
      t.column :name, :string
      t.money :total_asset
      t.timestamps
    end
  end
end
