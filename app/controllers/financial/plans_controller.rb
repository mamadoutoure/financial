require_dependency "financial/application_controller"

module Financial
  class PlansController < ApplicationController
    def index
      @plan = Plan.new
      #see http://stackoverflow.com/questions/4867880/nested-attributes-in-rails-3
      @plan.build_mortgage
      @plan.build_investment
      @plans = Plan.all
    end

    def create
      @plan = Plan.new(params[:plan])
      if @plan.save #valid plan
        @saved_plan = @plan #used to render recently added plan
        @plan = Plan.new(params[:plan]) #used to populate form
      else
        #return the plan with error to be displayed
      end
      render "add_new_plan"
    end

    def destroy
      @plan = Plan.find(params[:id])
      @plan.destroy
      render "delete_plan"
    end

    def show
      @plan = Plan.find(params[:id])
    end
  end
end
