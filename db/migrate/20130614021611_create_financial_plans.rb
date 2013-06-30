class CreateFinancialPlans < ActiveRecord::Migration
  def change
    create_table :financial_plans do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
