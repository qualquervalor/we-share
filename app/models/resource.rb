class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :borrows
  has_many :borrowers, source: :user, through: :borrow

  mount_uploader :picture, ImageUploader


  def self.search(search)
    if search
      find(:all, :conditions => ['name ILIKE ? OR description ILIKE ?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end


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

  def already_associated_with_borrower?( user)
   # check if there is a borrow between resource and norrower that is not completed
    flag = false
    user.borrows.each do |borrow|
      if borrow.resource == self
         if borrow.status == Borrow.pending || borrow.status == Borrow.borrowed 
            flag = true
          end
      end
    end
    flag
  end

end
