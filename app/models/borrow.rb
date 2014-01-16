class Borrow < ActiveRecord::Base
  validates :user, :resource, :status, presence: true
  belongs_to :user
  belongs_to :resource

  @@PENDING = "Pending"
  @@DENIED = "Denied"
  @@BORROWED = "Borrowed"
  @@RETURNED = "Returned"

  def self.pending
    @@PENDING
  end
  def self.denied
    @@DENIED
  end
  def self.borrowed
    @@BORROWED
  end
  def self.returned
    @@RETURNED
  end

  def update_status(new_status)
    @borrow.status = new_status
    
  end
end
