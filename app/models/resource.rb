class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :borrows
  has_many :borrowers, source: :user, through: :borrow

  mount_uploader :picture, ImageUploader

end
