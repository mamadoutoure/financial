module Financial
  class Mortgage < ActiveRecord::Base
    attr_accessible :init_val, :int_rate, :monthly_dep, :inv_months

    def future_value
      return init_val*((1 + int_rate)**inv_months - 1)/int_rate
    end
  end
end
