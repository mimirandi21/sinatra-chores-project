class Child < ActiveRecord::Base
    belongs_to :parent
    has_many :chores
    has_secure_password
end
