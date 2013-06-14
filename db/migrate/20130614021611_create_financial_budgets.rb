class CreateFinancialBudgets < ActiveRecord::Migration
  def change
    create_table :financial_budgets do |t|
      t.column :name, :string
      t.column :total_asset, :decimal, :precision=>12, :scale=>2
      t.timestamps
    end
  end
end
