class CreateFinancialInvesments < ActiveRecord::Migration
  def change
    create_table :financial_invesments do |t|
      t.column :principal, :decimal, :precision=>12, :scale=>2
      t.column :rate, :decimal, :precision=>12, :scale=>2
      t.column :monthly_dep, :decimal, :precision=>12, :scale=>2
      t.column :months, :integer
      t.timestamps
    end
  end
end