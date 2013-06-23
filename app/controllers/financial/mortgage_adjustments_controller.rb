require_dependency "financial/application_controller"

module Financial
  class MortgageAdjustmentsController < ApplicationController
    #update or create a new adjustment if an adjustment already exist for the given month, update it
    def create
      existing_adj = MortgageAdj.where(:mortgage_id=>params[:adjustment][:mortgage_id],:month=>params[:adjustment][:month]).first
      if existing_adj.blank?
        adjustment = MortgageAdj.new(params[:adjustment])
        adjustment.save
      else
        existing_adj.attributes=params[:adjustment]
        existing_adj.save
      end

      redirect_to :controller=>:budgets, :action=>:show, :id=>adjustment.mortgage_id
    end

    def destroy
      existing_adj = MortgageAdj.find(params[:id])
      existing_adj.destroy
      redirect_to :controller=>:budgets, :action=>:show, :id=>existing_adj.mortgage_id
    end
  end
end
