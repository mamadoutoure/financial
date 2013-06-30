# This migration comes from financial (originally 20130614021611)
class CreateFinancialPlans < ActiveRecord::Migration
  def change
    create_table :financial_plans do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
