module Financial
  class Finance < ActiveRecord::Base
    monetize :net_mothly_income_cents, :numericality=>{:greater_than_or_equal_to=>0}
    monetize :net_monthly_expense_cents, :numericality=>{:greater_than_or_equal_to=>0}

    attr_accessible :net_mothly_income, :net_monthly_expense, :person_id

    belongs_to :person
  end
end
