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
      if @budget.save #valid budget
        @saved_budget = @budget #used to render recently added budget
        @budget = Budget.new(params[:budget]) #used to populate form
      else
        #return the budget with error to be displayed
      end
      render "add_new_budget"
    end

    def destroy
      @budget = Budget.find(params[:id])
      @budget.destroy
      render "delete_budget"
    end

    def show
      @budget = Budget.find(params[:id])
    end
  end
end
