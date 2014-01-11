class User < ActiveRecord::Base
  has_many :resources
  has_many :borrows
  has_many :borrowed_resources, class_name: "resource", through: :borrows
end
