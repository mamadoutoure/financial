# This migration comes from financial (originally 20130609215709)
class CreateFinancialPaymentTypes < ActiveRecord::Migration
  def change
    create_table :financial_payment_types do |t|
      t.column :description, :string, :limit=>64
      t.timestamps
    end
  end
end
