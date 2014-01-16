class Borrow < ActiveRecord::Base
  validates :resource, :user, :status, presence: true
  belongs_to :user
  belongs_to :resource

  def update_status(new_status)
    @borrow.status = new_status
    
  end
end
