class CreateFinancialInvestments < ActiveRecord::Migration
  def change
    create_table :financial_investments do |t|
      t.money :principal
      t.column :rate, :decimal, :precision=>12, :scale=>2
      t.money :monthly_dep
      t.column :months, :integer
      t.column :plan_id, :integer
      t.timestamps
    end
  end
end
