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
