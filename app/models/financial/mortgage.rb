module Financial
  class Mortgage < ActiveRecord::Base
    #loan_term count by year
    #all tax and insurance are year amount
    #revenue: amount gain by renting part of the building, count by year
    attr_accessible :purchased_price, :down_payment, :interest, :loan_term, :municipal_tax, :school_tax, :heating, :house_insurance, :mortgage_insurance, :revenue, :avg_monthly_expense, :net_monthly_income
    belongs_to :budget
    has_many :mortgage_adjs, :dependent => :destroy
    #TODO: add validation

    def monthly_mortgage_payment
      @mmp = (loan * monthly_interest / (1-(1+monthly_interest)**(loan_term*(-12)))) if @mmp.blank?
      return @mmp
    end

    #total amount need to be paid to bank + municipal + school tax + heating + house insurance for whole building
    #TODO: not yet apply mortgage insurance, assuming we always down payment > 20% to avoid mortgage insurance 
    def monthly_payment
      return monthly_mortgage_payment + (municipal_tax + school_tax + heating + house_insurance)/12
    end

    #amount need to pay after revenue deduction
    def net_monthly_payment
      return (monthly_payment - revenue/12)
    end

    #amount left after all spending
    def monthly_saving
      return (net_monthly_income - net_monthly_payment - avg_monthly_expense)
    end

    def loan_balance_after(year)
      elapse_year = year #ridiculous but make it clear for dummy
      year_left = loan_term - elapse_year
      return (monthly_mortgage_payment * (1- (1+monthly_interest)**(year_left*(-12))) / monthly_interest)
    end

    def total_payment_after(year)
      elapse_year = year #ridiculous but make it clear for dummy
      return (monthly_mortgage_payment * elapse_year * 12)
    end

    def payoff_amount_after(year)
      elapse_year = year #ridiculous but make it clear for dummy
      loan = purchased_price - down_payment #TODO: refactor
      return loan - loan_balance_after(elapse_year)
    end

    def total_interest_after(year)
      elapse_year = year #ridiculous but make it clear for dummy
      return total_payment_after(elapse_year) - payoff_amount_after(elapse_year)
    end

    def total_cost_after(year)
      elapse_year = year #ridiculous but make it clear for dummy
      return down_payment + total_payment_after(elapse_year) + loan_balance_after(elapse_year)
    end

    #return the amount of extra payment for the selected year, zero if no extra payment made on tha year
    def extra_payment_for(month)
      return cached_adjustments[month].try(:amount).to_f
    end

    #TODO: take into account interest rate change
    def amortization
      amo = [{:month=>0, :interest=>0, :balance=>loan, :xtra_payment=>0, :new_rate=>nil, :adj_id=>nil}] #before any payment, we only have 100% loan
      current_month = 1
      loan_duration = loan_term * 12  #in months
      prev_balance = loan
      while current_month < loan_duration   #calculate for each month
        current_interest= (prev_balance * in_rate)/12  #TODO: rate can be changed
        capital_deduction= current_monthly_mortgage_payment(current_month) - current_interest #TODO: monthly_mortgage_payment will be changed because of rate change every 5 year
        extra_payment = extra_payment_for(current_month)
        current_balance = prev_balance - capital_deduction - extra_payment
        amo << {:month=>current_month, :interest=>current_interest,
                :cap_deduction=>capital_deduction, :balance=>current_balance,
                :xtra_payment=>extra_payment, :new_rate=>cached_adjustments[current_month].try(:interest),
                :adj_id=>cached_adjustments[current_month].try(:id)}

        if current_balance <= 0
          break
        end
        current_month = current_month + 1
        prev_balance = current_balance
      end
      return amo
    end
  protected
    def current_monthly_mortgage_payment(month)
      new_rate = nil
      #find the adjustment before this month which has the interest rate changed
      #TODO: this is a very bad performance, use the cached_adjustments if possible
      #new_rate = self.mortgage_adjs.where("interest IS NOT NULL").where("month >= ?", month).order(:month).first.try(:interest)
      if new_rate.nil?
        return monthly_mortgage_payment
      else
        #TODO: recalculate monthly mortgage payment for the rest of the loan period with the new interest rate  
      end      
    end
    #return a hash of adjustment for this mortgage, with key is the month
    def cached_adjustments
      if @adjs.nil?
        @adjs = {}
        self.mortgage_adjs.all.each do |adj|
          @adjs[adj.month]=adj
        end
      end
      return @adjs
    end

    def loan
      @l = (purchased_price - down_payment) if @l.blank?
      return @l
    end

    def in_rate
      @interest_rate = self.interest/100 if @interest_rate == nil
      return @interest_rate
    end
    #no compound on monthly interest
    def monthly_interest
      @m_interest = in_rate/12 if @m_interest == nil
      return @m_interest
    end
  end
end
