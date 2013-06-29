require_dependency "financial/application_controller"

module Financial
  class FinancesController < ApplicationController
    skip_before_filter :check_user_finance, :only => [:new, :create]

    def new
      @finance = @person.finance.build
    end

    def create
      if @person.finance.blank?
        @finance = Finance.new(params[:finance])
      else
        @finance = @person.finance
        @finance.attributes=params[:finance]
      end
      if @finance.save
        redirect_to plans_path
      else
        render :new
      end
    end
  end
end
