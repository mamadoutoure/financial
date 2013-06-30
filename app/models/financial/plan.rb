module Financial
  class Plan < ActiveRecord::Base
    attr_accessible :name, :mortgage_attributes, :investment_attributes

    before_save :set_values

    has_one :mortgage, :dependent => :destroy
    has_one :investment, :dependent => :destroy

    #it can have more, TODO: make it polymophic association
    accepts_nested_attributes_for :mortgage
    accepts_nested_attributes_for :investment
    
    validates_associated :mortgage
    validates_associated :investment

    protected
    #set default friendly name if not provided, sum investment and mortgage down payment
    def set_values
      if self.name.blank?
        self.name = Time.now.to_s
      end
    end
  end
end