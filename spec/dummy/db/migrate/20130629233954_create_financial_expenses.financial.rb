# This migration comes from financial (originally 20130609215323)
class CreateFinancialExpenses < ActiveRecord::Migration
  def change
    create_table :financial_expenses do |t|
      t.column :exp_date , :date
      t.column :exp_type_id, :integer
      t.money :amount
      t.column :note, :string, :limit=>300
      t.column :payment_type_id, :integer
      t.timestamps
    end
  end
end
