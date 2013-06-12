class CreateFinancialPaymentTypes < ActiveRecord::Migration
  def change
    create_table :financial_payment_types do |t|
      t.column :description, :string, :limit=>64
      t.timestamps
    end
  end
end
