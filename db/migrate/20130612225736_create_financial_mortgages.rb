class CreateFinancialMortgages < ActiveRecord::Migration
  def change
    create_table :financial_mortgages do |t|
      t.money :purchased_price
      t.money :down_payment
      t.column :interest, :decimal, :precision=>12, :scale=>2
      t.column :loan_term, :integer
      t.money :municipal_tax
      t.money :school_tax
      t.money :heating
      t.money :house_insurance
      t.money :mortgage_insurance
      t.money :revenue
      t.money :avg_monthly_expense
      t.money :net_monthly_income
      t.column :budget_id, :integer
      t.timestamps
    end
  end
end
