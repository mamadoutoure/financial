module Financial
  class Person < ActiveRecord::Base
    set_table_name :users

    attr_accessible :email

    has_one :finance
  end
end
