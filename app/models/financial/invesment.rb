module Financial
  class Invesment < ActiveRecord::Base
    attr_accessible :principal, :rate, :monthly_dep, :months 
    belongs_to :budget
    def future_value
      percentage_rate = rate / 100
      yearly_dep = monthly_dep * 12
      
      future_value_of_principal = principal*(1+percentage_rate)**(months/12)
      future_value_of_monthly_dep = yearly_dep*(((1+percentage_rate)**(months/12)) -1)/percentage_rate
      
      return (future_value_of_monthly_dep + future_value_of_principal)
    end
  end
end
