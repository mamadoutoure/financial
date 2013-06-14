module Financial
  class Budget < ActiveRecord::Base
    attr_accessible :name, :total_asset
  end
end
