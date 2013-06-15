require_dependency "financial/application_controller"

module Financial
  class BudgetsController < ApplicationController
    def index
      @budget = Budget.new
      @budget.build_mortgage
      @budget.build_investment
      @budgets = Budget.all
    end

    def create
      @budget = params[:budget]
      @budget.save
      render "add_new_budget"
    end
  end
end
