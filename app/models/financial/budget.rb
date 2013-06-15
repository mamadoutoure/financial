module Financial
  class Budget < ActiveRecord::Base
    attr_accessible :name, :total_asset
    has_one :mortgage
    has_one :investment
    #it can have more, TODO: make it polymophic association
    accepts_nested_attributes_for :mortgage
    accepts_nested_attributes_for :investment
  end
end
