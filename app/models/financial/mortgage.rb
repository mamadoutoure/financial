module Financial
  class Mortgage < ActiveRecord::Base
    #loan_term count by year
    #all tax and insurance are year amount
    #revenue: amount gain by renting part of the building, count by year
    attr_accessible :purchased_price, :down_payment, :interest, :loan_term, :municipal_tax, :school_tax, :heating, :house_insurance, :mortgage_insurance, :revenue, :avg_monthly_expense, :net_monthly_income
    belongs_to :budget

    def monthly_mortgage_payment
      loan = purchased_price - down_payment
      return (loan * monthly_interest / (1-(1+monthly_interest)**(loan_term*(-12))))
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
  protected
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
