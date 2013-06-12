class CreateFinancialMortgages < ActiveRecord::Migration
  def change
    create_table :financial_mortgages do |t|
      t.column :init_val, :decimal, :precision=>12, :scale=>2
      t.column :int_rate, :decimal, :precision=>12, :scale=>2
      t.column :monthly_dep, :decimal, :precision=>12, :scale=>2
      t.column :inv_months, :integer
      t.timestamps
    end
  end
end
