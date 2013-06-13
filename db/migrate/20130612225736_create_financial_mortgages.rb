class CreateFinancialMortgages < ActiveRecord::Migration
  def change
    create_table :financial_mortgages do |t|
      t.column :purchased_price, :decimal, :precision=>12, :scale=>2
      t.column :down_payment, :decimal, :precision=>12, :scale=>2
      t.column :interest, :decimal, :precision=>12, :scale=>2
      t.column :loan_term, :integer
      t.column :municipal_tax, :decimal, :precision=>12, :scale=>2
      t.column :school_tax, :decimal, :precision=>12, :scale=>2
      t.column :heating, :decimal, :precision=>12, :scale=>2
      t.column :house_insurance, :decimal, :precision=>12, :scale=>2
      t.column :mortgage_insurance, :decimal, :precision=>12, :scale=>2
      t.column :revenue, :decimal, :precision=>12, :scale=>2
      t.column :avg_monthly_expense, :decimal, :precision=>12, :scale=>2
      t.column :net_monthly_income, :decimal, :precision=>12, :scale=>2
      t.timestamps
    end
  end
end
