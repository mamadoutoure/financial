class CreateFinancialInvestments < ActiveRecord::Migration
  def change
    create_table :financial_investments do |t|
      t.column :principal, :decimal, :precision=>12, :scale=>2
      t.column :rate, :decimal, :precision=>12, :scale=>2
      t.column :monthly_dep, :decimal, :precision=>12, :scale=>2
      t.column :months, :integer
      t.column :budget_id, :integer
      t.timestamps
    end
  end
end
