class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :borrows
  has_many :borrowers, source: :user, through: :borrow

  mount_uploader :picture, ImageUploader

  def as_json(options={})
    {
      distance: options[:distance],
      id: self.id,
      name: self.name,
      description: self.description,
      picture: self.picture.url
    }
  end

  def get_distance(user1,user2)
  {
    distance: sprintf('%.2f',Haversine.distance(user1.latitude,user1.longitude,user2.latitude,user2.longitude).to_miles)
  }
  end

end
