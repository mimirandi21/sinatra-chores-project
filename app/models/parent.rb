class Parent < ActiveRecord::Base
    has_many :children
    has_many :chores
    has_secure_password
    validates :email, :presence => true, :uniqueness => true
end
