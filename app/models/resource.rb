class Resource < ActiveRecord::Base
  validates :name, :user, presence: true
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
      picture: self.picture.url,
      owner: options[:owner]
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

end
