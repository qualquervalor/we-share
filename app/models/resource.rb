class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :borrows
  has_many :borrowers, class_name: "user", through: :borrow

  mount_uploader :picture, ImageUploader

  def as_json(options={})
    {
      id: self.id,
      name: self.name,
      description: self.description,
      picture: self.picture.url
    }
  end

end
