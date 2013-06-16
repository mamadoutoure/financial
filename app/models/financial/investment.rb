module Financial
  class Investment < ActiveRecord::Base
    attr_accessible :principal, :rate, :monthly_dep, :months, :alt_rate, :alt_monthly_dep, :alt_length
    #virtual attributes
    attr_reader :alt_rate, :alt_monthly_dep, :alt_length
    
    belongs_to :budget
    attr_reader :foo

    #setter for virtual attributes with auto cast
    #see http://stackoverflow.com/questions/11561141/type-cast-an-activerecord-model-virtual-attribute
    def alt_rate=(value)
      @alt_rate = ActiveRecord::ConnectionAdapters::Column.value_to_decimal(value)
    end

    def alt_monthly_dep=(value)
      @alt_monthly_dep = ActiveRecord::ConnectionAdapters::Column.value_to_decimal(value)
    end

    def alt_length=(value)
      @alt_length = ActiveRecord::ConnectionAdapters::Column.value_to_decimal(value)
    end

    def future_value
      percentage_rate = rate / 100
      yearly_dep = monthly_dep * 12
      
      future_value_of_principal = principal*(1+percentage_rate)**(months/12)
      future_value_of_monthly_dep = yearly_dep*(((1+percentage_rate)**(months/12)) -1)/percentage_rate
      
      return (future_value_of_monthly_dep + future_value_of_principal)
    end
  end
end
