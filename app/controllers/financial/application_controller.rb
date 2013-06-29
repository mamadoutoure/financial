module Financial
  class ApplicationController < ActionController::Base
    before_filter RubyCAS::Filter

    layout 'layouts/application'
  end
end
