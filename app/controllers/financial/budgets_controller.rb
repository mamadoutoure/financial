require_dependency "financial/application_controller"

module Financial
  class BudgetsController < ApplicationController
    def index
      @budget = Budget.new
      #see http://stackoverflow.com/questions/4867880/nested-attributes-in-rails-3
      @budget.build_mortgage
      @budget.build_investment
      @budgets = Budget.all
    end

    def create
      @budget = Budget.new(params[:budget])
      @budget.save
      render "add_new_budget"
    end
  end
end
