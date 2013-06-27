class CreateFinancialMortgageAdjs < ActiveRecord::Migration
  def change
    create_table :financial_mortgage_adjs do |t|
      t.column :month, :integer
      t.money :amount
      t.column :interest, :decimal, :precision=>12, :scale=>2
      t.column :mortgage_id, :integer
      t.timestamps
    end
  end
end
