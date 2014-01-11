class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :borrows
  has_many :borrowers, class_name: "user", through: :borrow

  mount_uploader :picture, ImageUploader

end
