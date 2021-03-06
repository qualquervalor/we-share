class Resource < ActiveRecord::Base
  validates :name, :user, presence: true
  belongs_to :user
  has_many :borrows, :dependent => :destroy
  has_many :borrowers, source: :user, through: :borrow

  mount_uploader :picture, ImageUploader

  paginates_per 10


  def self.search(search)
    if search
      find(:all, :conditions => ['name ILIKE ? OR description ILIKE ?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end


  def as_json(options={})
    {
      id: self.id,
      name: self.name.truncate(15),
      description: self.description,
      picture: self.picture.url,
      owner: self.user.name
    }
  end


  def already_associated_with_borrower?( user)
   # check if there is a borrow between resource and borrower that is not completed
    id = false
    user.borrows.each do |borrow|
      if borrow.resource == self
         if borrow.status == Borrow.pending || borrow.status == Borrow.borrowed 
            id = borrow.id
          end
      end
    end
    id
  end

  def currently_checked_out
    params = {:status => Borrow.borrowed, :resource_id => self.id}
    Borrow.find(:first, :conditions => ["status LIKE :status AND resource_id = :resource_id", params])
  end

end
