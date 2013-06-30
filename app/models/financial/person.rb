module Financial
  class Person < ActiveRecord::Base
    set_table_name :users

    attr_accessible :email

    has_one :finance, :dependent => :destroy
    has_many :plans, :dependent => :destroy
  end
end
