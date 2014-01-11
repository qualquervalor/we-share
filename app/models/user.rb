class User < ActiveRecord::Base
  has_many :resources
  has_many :borrows
  has_many :resources, through: :borrows
end
