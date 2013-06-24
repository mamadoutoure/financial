module Financial
  class MortgageAdj < ActiveRecord::Base
    #month: selected month
    #amount: extra payment for the selected year
    #interest: new interest rate applied since the selected year
    attr_accessible :month, :amount, :interest, :mortgage_id
    belongs_to :mortgage

    validates_associated :mortgage
    validates :month, :presence => true
    validates :amount, :interest, :numericality => true , :allow_blank=>true
    validates :month, :numericality => { :only_integer => true } , :allow_blank=>true

    protected
    
    def rate
      @r = self.interest/100 if @r.blank?
      return @r
    end
  end
end
