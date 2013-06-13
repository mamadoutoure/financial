module Financial
  class Mortgage < ActiveRecord::Base
    attr_accessible :init_val, :int_rate, :monthly_dep, :inv_months

    def future_value
      yearly_dep = monthly_dep * 12
      #i = int_rate/12 #monthly interest rate
      future_value_of_init_val = init_val*(1+int_rate)**(inv_months/12)
      future_value_of_monthly_dep = yearly_dep*(((1+int_rate)**(inv_months/12)) -1)/int_rate
      return (future_value_of_monthly_dep + future_value_of_init_val)
    end
  end
end
