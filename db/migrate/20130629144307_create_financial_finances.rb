class CreateFinancialFinances < ActiveRecord::Migration
  def change
    create_table :financial_finances do |t|
      t.money :net_monthly_income
      t.money :net_monthly_expense
      t.column :person_id, :integer
      t.timestamps
    end
  end
end
